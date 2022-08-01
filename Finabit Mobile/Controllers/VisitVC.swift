//
//  VisitVC.swift
//  Finabit Mobile
//  Created by Hivzi on 23.3.22.
//

import UIKit
import CoreData
import CoreLocation

class VisitVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, CLLocationManagerDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var visit: Visit?
    private var partnerId: Int16?
    private var partnerName: String?
    private var dueVaule: Double?
    private var discontPercent: Double?
    private var partnerPicture: NSData?
    private var startLongitude = ""
    private var startLatitude = ""
    @IBOutlet weak var selectedClient: UILabel!
    var startOfVisit = ""
    @IBOutlet weak var clientLabel: UIButton!
    var transactionTypeInVisit = 0
    var chosenClient: PartnerInSqLite?
    let imagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOfVisit = getDate()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func getDate() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: currentDateTime)
        return result
    }
    
    
    @IBAction func choseClient(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Client") as! ClientVC
        present(vc, animated: true)
        vc.modalPresentationStyle = .popover
        vc.completionHandler = { client in
            self.selectedClient.text = client.partnerName
            self.partnerName = client.partnerName
            self.partnerId = client.partnerID
            self.dueVaule = client.dueValue
            self.discontPercent = client.discountPercent
        }
    }
    
    @IBAction func merrFoto(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            let image2 = image.pngData()  as? NSData
            partnerPicture = image2
            imagePicker.dismiss(animated: true, completion: nil)
        } else {
            print("nuk u gjen foto")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            startLongitude = "\(location.coordinate.latitude)"
            startLatitude = "\(location.coordinate.longitude)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // se pari shikohet nese eshte zgjedhur klienti, nese eshte zgjedhur, merret departmentId nga UserDefault dhe visitId rritet +1 nga vlera e vizites se fundit. Me pas ndertohet visit si objekt dhe ruhet ne CoreData
    @IBAction func vazhdoPressed(_ sender: UIButton) {
        if partnerId != nil {
            guard let departmentId = UDM.shared.defaults.value(forKey: "defaultDepartment") as? String else { return  }
            var visitId = 0
            let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
            
            do {
                let lastVisit =  try context.fetch(request).last
                if let lastSafeVisit = lastVisit {
                    visitId = Int(lastSafeVisit.visitId) + 1
                }
            } catch {
            }
            
            visit =  Visit(visitId: visitId, updatePartnerCoords: 0, syncID: 1, setPartnerPosition: 1, setPartnerPicture: 0, partnerPicture: partnerPicture, partnerID: partnerId, memoID: 0, longitudeEnd: nil, longitudeBegin: startLongitude, latitudeEnd: nil, latitudeBegin: startLatitude, isSynchronized: 0, insBy: 1, hasErrorSync: 1, endingDate: nil, beginningDate: startOfVisit, departmentId: Int(departmentId), partnerName: partnerName, dueValue: dueVaule, discontPercent: discontPercent)
            if let safeVisit = visit {
                PersistenceManager.shared.addVisitToCoreData(visit: safeVisit)
                performSegue(withIdentifier: "VisitToNewOrder", sender: self)
            }
        } else {
            showAlertClientIsNotChosen()
        }
    }
    //transactioType i marrun nga Porosia apo Shitja percjellet te NewOrderVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? NewOrderVC
        if segue.identifier == "VisitToNewOrder"  {
            destinationVC?.transactionType = Int32(transactionTypeInVisit)
        }
        else  {
            
        }
    }
    
    // nese anulohet vizita, kodi e ka efektin e njejte si back buttoni te Navigation
    @IBAction func anuloPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    private func showAlertClientIsNotChosen() {
        let alert = UIAlertController(title: "Verejtje", message: "Duhet ta zgjedhni se pari konsumatorin", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}


