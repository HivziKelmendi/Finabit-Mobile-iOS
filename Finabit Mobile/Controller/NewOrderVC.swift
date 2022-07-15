//
//  NewOrderVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 27.3.22.
//

import UIKit
import CoreData

class NewOrderVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    
    let urlToUpload = Constants.urlToUpload
    var transaction: Transaction?
    var transactionDetails: [TransactionDetails] = []
    
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
        shifraTextField.delegate = self
        emertimiTextField.delegate = self
        sasiaTextField.delegate = self
        cmimiTextField.delegate = self
        rabatTextField.delegate = self
        rabat2TextField.delegate = self
            }
    
    override func viewWillAppear(_ animated: Bool) {
        departmentLabel.text = deartmentName
    }
        
    func fetchLastVisit() {
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        do {
            guard let lastVisit =  try context.fetch(request).last else {return}
            transactionDate = getDate()
            partnerId = lastVisit.partnerID
            partnerName = lastVisit.partnerName
            visitId = lastVisit.visitId
            longitude = lastVisit.longitudeEnd
            latitude = lastVisit.longitudeEnd
            internalDepartmentId = lastVisit.departmentId
            clientLable.text = partnerName
            dueValue.text =  "\(lastVisit.dueVaule ?? 0)"
            discountPercent.text = "\(lastVisit.discontPercent ?? 0)"
            dateLabel.text = getDateForLabel()
        } catch {
        }
    }
    
    @IBAction func getDpartmentPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Department") as! DepartmentVC
        present(vc, animated: true)
        vc.modalPresentationStyle = .popover
        vc.completionHandler = { chosenDepartment in
            self.deartmentName = chosenDepartment.departmentName
            self.departmentLabel.text = self.deartmentName
            self.departmentId = chosenDepartment.departmentID
            self.createTransaction()
        }
    }
    
    func getDate() -> String {
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
       
        let newRabat = (1 - (rabat ?? 0)/100)*(1 - (rabat2 ?? 0)/100)
        let value =  (cmim ?? 0)*(sasia ?? 0)*newRabat
        allValue += value
        let newTransactionDetails = TransactionDetails(id: transactionDetailsId, itemId: shifra, itemName: emertimi, quantity: sasia, price: cmim, value: value, transactionid: transactionId, rabat: rabat, rabat2: rabat2, priceMenuID: priceMenuId, barcode: barcode, unitId: unitId, coefficient: coefficient)
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
        
    @IBAction func saveTransactionAndTransactionDetails(_ sender: UIBarButtonItem) {
        if let safeTransaction = transaction   {
            PersistenceManager.shared.addTransactionToCoreData(transaction: safeTransaction)
        }

        PersistenceManager.shared.addTransactionDetailsToCoreData(transactionDetails: transactionDetails)
          endingDateForVisit = getDateToCloseVisit()
        updateVisitInSqLite()
        updateTransactionInSqLite()
        
        
        let uploadOrder = UploadOrder()
        uploadOrder.getDataToupload()
        uploadOrder.XMLUploadParser(url: urlToUpload) { UploadResponse in
            if UploadResponse != nil {
                print(UploadResponse)
                PersistenceManager.shared.SynchronizeData()
            }
        }
        showActionsheet()
        }
    
    func updateVisitInSqLite() {
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        do {
            guard let lastVisit =  try context.fetch(request).last else { return}
            lastVisit.setValue(endingDateForVisit, forKey: "endingDate")

        } catch {
     }
        do {
            try context.save()
          
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateTransactionInSqLite() {
        let request : NSFetchRequest<TransactionInSqLite> = TransactionInSqLite.fetchRequest()
        do {
            guard let lastTransaction =  try context.fetch(request).last else { return}
            lastTransaction.setValue(allValue, forKey: "allValue")

        } catch {
     }
        do {
            try context.save()
          
        } catch {
            print(error.localizedDescription)
        }
    }
         
    
    func showActionsheet() {
        let actionsheet = UIAlertController(title: "", message: "Mbyll Viziten", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
           print("cancel tapped")
        }))
        actionsheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(actionsheet, animated: true)
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
            shifra = textField.text
        case emertimiTextField:
            emertimi = textField.text
        case sasiaTextField:
            sasia = Double(textField.text ?? "0")
        case cmimiTextField:
            cmim = Double(textField.text ?? "0")
        case rabatTextField:
            rabat = Double(textField.text ?? "0")
        case rabat2TextField:
            rabat2 = Double(textField.text ?? "0")
        case unitNameTextField:
            unitName = textField.text
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

struct Transaction {
    var iD: Int32
    var transactionNo: String?
    var invoiceNo: String?
    var transactionType: Int32?
    var transactionDate: String?
    var partnerName: String?
    var partnerId: Int32?
    var visitId: Int32?
    var departmentId: Int16?
    var insDate: String?
    var insBY: Int32?
    var employeeId: Int32?
    var iSynchronized: Int32?
    var vATPrecentId: Int32?
    var dueDays: Int32?
    var paymentVaule: Double?
    var allValue: Double?
    var longitude: String?
    var latitude: String?
    var serviceTypeID: Int32?
    var assetId: Int32?
    var bl: Int32?
    var memo: String?
    var llogaria_NotaKreditore: String?
    var vlera_NotaKreditore: Double?
    var isPrintFiscalInvoice: Int32?
    var IsPriceFromPartner: Int32?
    var nrIFatBlerje: String?
    var internalDepartmentID: Int32?
    var verifyFiscal: Int32?
}

struct TransactionDetails {
    var id: Int32
    var itemId: String?
    var itemName: String?
    var quantity: Double?
    var price: Double?
    var value: Double?
    var transactionid: Int32?
    var rabat: Double?
    var rabat2: Double?
    var priceMenuID: Int16?
    var barcode: String?
    var unitId: Int16?
    var coefficient: Double?
}



