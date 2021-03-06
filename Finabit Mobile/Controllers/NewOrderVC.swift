//
//  NewOrderVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 27.3.22.
//

import UIKit
import CoreData
import CoreLocation



class NewOrderVC: UIViewController  {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    
    let urlToUpload = Constants.urlToUpload
    var transaction: Transaction?
    var transactionDetails: [TransactionDetails] = []
    let locationManager = CLLocationManager()
    
    private var deartmentName: String?
    private var departmentId: Int16?
    private var internalDepartmentId: Int32?
    private var transactionDate: String?
    private var partnerId: Int32?
    private var partnerName: String?
    private var visitId: Int32?
    private var dueDays: Int32?
    private var longitude: String?
    private var latitude: String?
    private var transactionId: Int32?
    var transactionType: Int32?
    
    private var allValue: Double = 0.0
    private var shifra: String?
    private var emertimi: String?
    private var sasia: Double?
    private var cmim: Double?
    private var rabat: Double?
    private var rabat2: Double?
    private var unitName: String?
    private var priceMenuId: Int16?
    private var barcode: String?
    private var unitId: Int16?
    private var coefficient: Double?
    private var currentVisit: Visit?
    private var transactionDetailsId: Int32 = 0
    private var endingDateForVisit = ""
    
    @IBOutlet weak var clientLable: UILabel!
    @IBOutlet weak var dueValue: UILabel!
    @IBOutlet weak var discountPercent: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var buttonPressed: UIButton!
    @IBOutlet weak var shifraTextField: UITextField!
    @IBOutlet weak var emertimiTextField: UITextField!
    @IBOutlet weak var sasiaTextField: UITextField!
    @IBOutlet weak var cmimiTextField: UITextField!
    @IBOutlet weak var rabatTextField: UITextField!
    @IBOutlet weak var rabat2TextField: UITextField!
    @IBOutlet weak var unitNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchLastVisit()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        shifraTextField.delegate = self
        emertimiTextField.delegate = self
        sasiaTextField.delegate = self
        cmimiTextField.delegate = self
        rabatTextField.delegate = self
        rabat2TextField.delegate = self
        locationManager.requestLocation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        departmentLabel.text = deartmentName
    }
    
   // merret vizita e fundit nga CoreData dhe mbushet pjesa per te dhenat e partnerit ne View Controller
    func fetchLastVisit() {
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        do {
            guard let lastVisit =  try context.fetch(request).last else {return}
            transactionDate = getDateForTransaction()
            partnerId = lastVisit.partnerID
            partnerName = lastVisit.partnerName
            visitId = lastVisit.visitId
            internalDepartmentId = lastVisit.departmentId
            clientLable.text = partnerName
            dueValue.text =  "\(lastVisit.dueVaule ?? 0)"
            discountPercent.text = "\(lastVisit.discontPercent ?? 0)"
            dateLabel.text = getDateForLabel()
        } catch {
        }
    }
    
   // pasi selektohet departmentin, formohet edhe transaksioni
    @IBAction func getDpartmentPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Department") as! DepartmentVC
        present(vc, animated: true)
        vc.modalPresentationStyle = .popover
        vc.completionHandler = { [self] chosenDepartment in
            self.deartmentName = chosenDepartment.departmentName
            self.departmentLabel.text = self.deartmentName
            self.departmentId = chosenDepartment.departmentID
            self.createTransaction()
        }
    }
      
   // me addItem dhe shtoPressed selektohen nje apo me shume artikuj dhe formohet transacionDetails
    @IBAction func addItem(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Item") as! ItemVC
        present(vc, animated: true)
        vc.modalPresentationStyle = .popover
        vc.completionHandler = { chosenItem in
            self.shifraTextField.text = chosenItem.itemID
            self.emertimiTextField.text = chosenItem.itemName
            self.sasiaTextField.text = chosenItem.quantity
            self.cmimiTextField.text =  "\(chosenItem.price ?? 0)"
            self.rabatTextField.text = "\(chosenItem.rabat ?? 0)"
            self.rabat2TextField.text = "\(chosenItem.rabat ?? 0)"
            self.unitNameTextField.text = chosenItem.unitName
            self.priceMenuId = chosenItem.priceMenuID
            self.barcode = chosenItem.barcode
            self.unitId = chosenItem.unitID1
            self.coefficient = chosenItem.coefficient
        }
    }
        
    @IBAction func shtoPressed(_ sender: UIButton) {
        var  rabat = Double(rabatTextField.text ?? "0")
        var rabat2 = Double(rabat2TextField.text ?? "0")
        var cmimi = Double(cmimiTextField.text ?? "0")
        var sasia = Double(sasiaTextField.text ?? "0")
        
        var  newRabat = (1 - (rabat ?? 0)/100)*(1 - (rabat2 ?? 0)/100)
        let value =  (cmimi ?? 0)*(sasia ?? 0)*newRabat
        allValue += value
        let newTransactionDetails = TransactionDetails(id: transactionDetailsId, itemId: shifraTextField.text, itemName: emertimiTextField.text, quantity: sasia, price: cmimi, value: value, transactionid: transactionId, rabat: rabat, rabat2: rabat2, priceMenuID: priceMenuId, barcode: barcode, unitId: unitId, coefficient: coefficient)
        transactionDetails.append(newTransactionDetails)
        transactionDetailsId += 1
        tableView.reloadData()
    }
    
    
    func createTransaction() {
        let request : NSFetchRequest<TransactionInSqLite> = TransactionInSqLite.fetchRequest()
        do {
            let lastTransaction =  try context.fetch(request).last
            if let lastSafeTransaction = lastTransaction {
                transactionId = lastSafeTransaction.iD + 1
            } else{
                transactionId = 0
            }
            
        } catch {
        }
        transaction = Transaction(iD: transactionId!, transactionNo: nil, invoiceNo: nil, transactionType: transactionType, transactionDate: transactionDate, partnerName: partnerName, partnerId: partnerId, visitId: visitId, departmentId: departmentId, insDate: transactionDate, insBY: nil, employeeId: nil, iSynchronized: 0, vATPrecentId: nil, dueDays: nil, paymentVaule: nil, allValue: nil, longitude: longitude, latitude: latitude, serviceTypeID: nil, assetId: nil, bl: nil, memo: nil, llogaria_NotaKreditore: nil, vlera_NotaKreditore: nil, isPrintFiscalInvoice: nil, IsPriceFromPartner: nil, nrIFatBlerje: nil, internalDepartmentID: internalDepartmentId, verifyFiscal: nil)
    }

    
    // shtypjen e ketij butoni, realizohen disa veprime: ruhen ne CoreData transaction dhe trnsactionDetails, pastaj thirret klasa UploadOrder per t'i derguar te shenimet permes web service ne databazen qendrore. Nese web service e kthen pergjegjen pozitive, behet sinkronizimi i databazes me CoreData. Sinkronizimi ta shfaqe imazhin e sinkornizimit te porosite dhe shitjet behet me Notification. Pastaj hapet actionsheet per mbylljen e vizites.
    @IBAction func saveTransactionAndTransactionDetails(_ sender: UIBarButtonItem) {
        if let safeTransaction = transaction   {
            PersistenceManager.shared.addTransactionToCoreData(transaction: safeTransaction)
        }
        
        PersistenceManager.shared.addTransactionDetailsToCoreData(transactionDetails: transactionDetails)
        updateTransactionInSqLite()
        
        let uploadOrder = UploadData()
        uploadOrder.getDataToupload()
        uploadOrder.XMLUploadParser(url: urlToUpload) { UploadResponse in
            if UploadResponse != nil {
                print(UploadResponse)
                PersistenceManager.shared.SynchronizeData()
                NotificationCenter.default.post(name: NSNotification.Name("true"), object: nil)
            }
        }
        showActionsheetToCloseVisit()
       
    }
    
    //Kur mbyllet vizita duhet tu perditesohen keto tri properties
    func updateVisitInSqLite() {
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        locationManager.requestLocation()
        do {
            guard let lastVisit =  try context.fetch(request).last else { return}
            lastVisit.setValue(endingDateForVisit, forKey: "endingDate")
            lastVisit.setValue(latitude, forKey: "latitudeEnd")
            lastVisit.setValue(longitude, forKey: "longitudeEnd")
        } catch {
        }
        do {
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // pasi transaksioni eshte i formuar para se te dihet vlera e transacionDetails, allValue qe eshte vlera totale e transactionit, behet update
    func updateTransactionInSqLite() {
        let request : NSFetchRequest<TransactionInSqLite> = TransactionInSqLite.fetchRequest()
        do {
            guard let lastTransaction =  try context.fetch(request).last else { return}
            lastTransaction.setValue(allValue, forKey: "allValue")
        }
        catch {
        }
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //
    func showActionsheetToCloseVisit() {
        let actionsheet = UIAlertController(title: "", message: "Mbyll Viziten", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("cancel tapped")
        }))
        actionsheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.endingDateForVisit = self.getDateToCloseVisit()
            self.updateVisitInSqLite()
            // me waitingScreen e vonojme 10 sekonda kalimin per shkak se duhet kohe qe ta behen sinkronizimet e shenimeve
            let waitingScreen = self.waitingScreen()
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        self.stopwaitingScreen(loader: waitingScreen)
                     self.navigationController?.popToRootViewController(animated: true)
                    }
          
        }))
        present(actionsheet, animated: true)
    }
    
    
    func getDateForTransaction() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: currentDateTime)
        return result
    }
    
    func getDateForLabel() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: currentDateTime)
        return result
    }
    
    func getDateToCloseVisit() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: currentDateTime)
        return result
    }
}


extension NewOrderVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case shifraTextField:
            shifraTextField.text = textField.text
        case emertimiTextField:
            emertimiTextField.text = textField.text
        case sasiaTextField:
            sasiaTextField.text = textField.text ?? ""
        case cmimiTextField:
            cmimiTextField.text = textField.text ?? ""
        case rabatTextField:
            rabatTextField.text = textField.text ?? "0"
        case rabat2TextField:
            rabat2TextField.text = textField.text ?? "0"
        case unitNameTextField:
            unitNameTextField.text = textField.text
        default:
            print("error")
        }
    }
}

extension NewOrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)  as? TransactionCell else {return UITableViewCell()}
        
        DispatchQueue.main.async
        {
            let newTransactionDetails = self.transactionDetails[indexPath.row]
            cell.updateCell(from: newTransactionDetails)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        transactionDetails.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 80
        return cellHeight
    }
}


extension NewOrderVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            latitude = "\(location.coordinate.latitude)"
            longitude = "\(location.coordinate.longitude)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}








