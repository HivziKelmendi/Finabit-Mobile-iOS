//
//  VisitVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 23.3.22.
//

import UIKit
import CoreData

class VisitVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var visit: Visit?
    private var partnerId: Int16?
    private var partnerName: String?
    private var dueVaule: Double?
    private var discontPercent: Double?
    @IBOutlet weak var selectedClient: UILabel!
    var startOfVisit = ""
    @IBOutlet weak var clientLabel: UIButton!

    var chosenClient: PartnerInSqLite?
    override func viewDidLoad() {
        super.viewDidLoad()
      startOfVisit = getDate()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        selectedClient.text = chosenClient?.partnerName
//    }
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
    

    @IBAction func vazhdoPressed(_ sender: UIButton) {
        guard let departmentId = UDM.shared.defaults.value(forKey: "defaultDepartment") as? String else { return  }

        var visitId = 0
        let endVisit = getDate()
//        var partnerId = (chosenClient?.partnerID)!
//        var partnerName = chosenClient?.partnerName
//        var dueVaule = chosenClient?.dueValue
//        var discontPercent = chosenClient?.discountPercent
        
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()

        do {
            let lastVisit =  try context.fetch(request).last
            if let lastSafeVisit = lastVisit {
                visitId = Int(lastSafeVisit.visitId) + 1
            }
             
        } catch {
            
        }
        print(visitId)
         visit =  Visit(visitId: visitId, updatePartnerCoords: 0, syncID: 1, setPartnerPosition: 1, setPartnerPicture: 0, partnerPicture: nil, partnerID: partnerId, memoID: 0, longitudeEnd: nil, longitudeBegin: nil, latitudeEnd: nil, latitudeBegin: nil, isSynchronized: 0, insBy: 1, hasErrorSync: 1, endingDate: nil, beginningDate: startOfVisit, departmentId: Int(departmentId), partnerName: partnerName, dueValue: dueVaule, discontPercent: discontPercent)
        if let safeVisit = visit {
            PersistenceManager.shared.addVisitToCoreData(visit: safeVisit)
                      
                  performSegue(withIdentifier: "VisitToNewOrder", sender: self)
           }
        }
    }


struct Visit {
    var visitId: Int
    var updatePartnerCoords: Int?
    var syncID: Int?
    var setPartnerPosition: Int?
    var setPartnerPicture: Int?
    var partnerPicture: NSData?
    var partnerID: Int16?
    var memoID: Int?
    var longitudeEnd: String?
    var longitudeBegin: String?
    var latitudeEnd: String?
    var latitudeBegin: String?
    var isSynchronized: Int?
    var insBy: Int?
    var hasErrorSync: Int?
    var endingDate: String?
    var beginningDate: String?
    var departmentId: Int?
    var partnerName: String?
    var dueValue:  Double?
    var discontPercent: Double?
   
}
