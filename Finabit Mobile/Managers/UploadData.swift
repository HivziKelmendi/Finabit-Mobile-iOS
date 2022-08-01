//
//  UpluadNewOrder.swift
//  Finabit Mobile
//
//  Created by Hivzi on 15.5.22.
//

import Foundation
import CoreData


class UploadData: NSObject, XMLParserDelegate {
    
    private var uploadResponse: UploadResponse?
    private var currentElement = ""
    private var currentSyncUploadResult: String = "" {
        didSet {
            currentSyncUploadResult = currentSyncUploadResult.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    func getDate(stringDate: String) -> Date? {
        var dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: stringDate)
    }
    
    var visits: [VisitInSqLite] = []
    var visitsToUpload: [UploadVisit] = []
    var transactions: [TransactionInSqLite] = []
    var transactionsToUpload: [UploadTransactions] = []
    var transactionDetails: [TransactionDetalisInSqLite] = []
    var transactionDetailsToUpload: [UploadTransactionDetails] = []
  
    // nga CoreData merren vizitat transaksionet dhe detajet e transaksionve dhe formohen objektet e reja identike me ato ne databazen qendrore
    func getDataToupload() {
        PersistenceManager.shared.fetchingVisitsForUpload { [self] result in
            switch result {
            case .success(let visits):
                self.visits = visits
                for visit in visits {
                    let newUploadVisit = UploadVisit(VisitID: Int(visit.visitId), BeginningDate:  visit.beginningDate, PartnerID: Int(visit.partnerID), EndingDate: visit.endingDate, IsSynchronized: Bool(truncating: visit.isSynchronized as NSNumber), InsBy: Int(visit.insBy), SyncID: visit.syncID, DepartmentID: Int(visit.departmentId), LongitudeBegin: Double(visit.longitudeBegin ?? "0"), LongitudeEnd: Double(visit.longitudeEnd ?? "0"), LatitudeBegin: Double(visit.latitudeBegin ?? "0"), LatitudeEnd: Double(visit.latitudeEnd ?? "0"), SetPartnerPosition: Bool(truncating: visit.setPartnerPosition as NSNumber), PartnerPicture: visit.partnerPicture, SetPartnerPicture: Bool(truncating: visit.setPartnerPicture as NSNumber), strPicture: "nil", UpdatePartnerCoords: Bool(truncating: visit.updatePartnerCoords as NSNumber))
                    self.visitsToUpload.append(newUploadVisit)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        PersistenceManager.shared.fetchingTransactionsForUpload { [self] result in
            switch result {
            case .success(let transactions):
                self.transactions = transactions
                for transaction in transactions {
                    let newUploadTransaction = UploadTransactions(TransactionNo: transaction.transactionNo  ?? "0", InvoiceNo: transaction.invoiceNo, TransactionType: transaction.transactionType, TransactionDate: transaction.transactionDate, PartnerID: transaction.partnerId, VisitID: transaction.visitId, DepartmentID: transaction.departmentId, InsDate: transaction.insDate, InsBy: transaction.insBY, EmployeeID: transaction.employeeId, IsSynchronized: Bool(truncating: transaction.iSynchronized as NSNumber), VATPrecentID: transaction.vATPrecentId, DueDays: transaction.dueDays, PaymentValue: transaction.paymentVaule, AllValue: transaction.allValue, Longitude: transaction.longitude, Latitude: transaction.latitude, ServiceTypeID: transaction.serviceTypeID, AssetID: transaction.assetId, BL: Bool(truncating: transaction.bl as NSNumber), Memo: transaction.memo, Llogaria_NotaKreditore: transaction.llogaria_NotaKreditore, Vlera_NotaKreditore: transaction.vlera_NotaKreditore, IsPrintFiscalInvoice: Bool(truncating: transaction.isPrintFiscalInvoice as NSNumber),IsPriceFromPartner: Bool(truncating: transaction.isPriceFromPartner as NSNumber), NrIFatBlerje: transaction.nrIFatBlerje, InternalDepartmentID: transaction.internalDepartmentID)
                    self.transactionsToUpload.append(newUploadTransaction)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        PersistenceManager.shared.fetchingTransactionsDetails { [self] result in
            switch result {
            case .success(let transactionDetails):
                self.transactionDetails = transactionDetails
                for transactionDetail in transactionDetails {
                    let newUploadTransactionDetail = UploadTransactionDetails(ItemID: transactionDetail.itemId, ItemName: transactionDetail.itemName, Quantity: transactionDetail.quantity, Price: transactionDetail.price, Value: transactionDetail.value, TransactionID: transactionDetail.transactionid, Rabat: transactionDetail.rabat, Rabat2: transactionDetail.rabat2, Rabat3: transactionDetail.rabat2, PriceMenuID: transactionDetail.priceMenuID, Barcode: transactionDetail.barcode, UnitID: transactionDetail.unitId, Coefficient: transactionDetail.coefficient)
                    self.transactionDetailsToUpload.append(newUploadTransactionDetail)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // ky funksion i konverton shenimet ne formatin XML
    func buildXMLString(visits: [UploadVisit]?, transactions: [UploadTransactions]?, transactionDetails: [UploadTransactionDetails]?) -> String {
        var xmlString = ""
        if let safeVisits = visits {
            xmlString  +=  "<Visits>"
            for visit in safeVisits {
                xmlString  += "<XMLVisits>"
                xmlString  += "<VisitID>\(visit.VisitID)</VisitID>"
                xmlString  += "<BeginningDate>\(visit.BeginningDate ?? "")</BeginningDate>"
                xmlString  += "<PartnerID>\(visit.PartnerID ?? 0)</PartnerID>"
                xmlString  += "<EndingDate>\(visit.EndingDate ?? "")</EndingDate>"
                xmlString  += "<IsSynchronized>\(visit.IsSynchronized ?? false)</IsSynchronized>"
                xmlString  += "<InsBy>\(visit.InsBy ?? 0)</InsBy>"
                xmlString  += "<SyncID>\(visit.SyncID ?? 0)</SyncID>"
                xmlString  += "<DepartmentID>\(visit.DepartmentID ?? 0)</DepartmentID>"
                xmlString  += "<LongitudeBegin>\(visit.LongitudeBegin ?? 0.0)</LongitudeBegin>"
                xmlString  += "<LongitudeEnd>\(visit.LongitudeEnd ?? 0.0)</LongitudeEnd>"
                xmlString  += "<LatitudeBegin>\(visit.LatitudeBegin ?? 0.0)</LatitudeBegin>"
                xmlString  += "<LatitudeEnd>\(visit.LatitudeEnd ?? 0.0)</LatitudeEnd>"
                xmlString  += "<SetPartnerPosition>\(visit.SetPartnerPosition ?? false)</SetPartnerPosition>"
                xmlString  += "<PartnerPicture></PartnerPicture>"
                xmlString  += "<SetPartnerPicture>\(visit.SetPartnerPicture ?? false)</SetPartnerPicture>"
                xmlString  += "<strPicture>\(visit.strPicture ?? "")</strPicture>"
                xmlString  += "<UpdatePartnerCoords>\(visit.UpdatePartnerCoords ?? false)</UpdatePartnerCoords>"
                xmlString  += "</XMLVisits>"
            }
            xmlString  +=  "</Visits>"
        }
        if let safeTransactions = transactions {
            xmlString  +=  "<Transations>"
            for transaction in safeTransactions {
                xmlString  += "<XMLTransactions>"
                xmlString  += "<TransactionNo>\(transaction.TransactionNo)</TransactionNo>"
                xmlString  += "<InvoiceNo>\(transaction.InvoiceNo ?? "0")</InvoiceNo>"
                xmlString  += "<TransactionType>\(transaction.TransactionType ?? 0)</TransactionType>"
                xmlString  += "<TransactionDate>\(transaction.TransactionDate ?? "0")</TransactionDate>"
                xmlString  += "<PartnerID>\(transaction.PartnerID ?? 0)</PartnerID>"
                xmlString  += "<VisitID>\(transaction.VisitID ?? 0)</VisitID>"
                xmlString  += "<DepartmentID>\(transaction.DepartmentID ?? 0)</DepartmentID>"
                xmlString  += "<InsDate>\(transaction.InsDate ?? "0")</InsDate>"
                xmlString  += "<InsBy>\(transaction.InsBy ?? 0)</InsBy>"
                xmlString  += "<EmployeeID>\(transaction.EmployeeID ?? 0)</EmployeeID>"
                xmlString  += "<IsSynchronized>\(transaction.IsSynchronized ?? false)</IsSynchronized>"
                xmlString  += "<VATPrecentID>\(transaction.VATPrecentID ?? 0)</VATPrecentID>"
                xmlString  += "<DueDays>\(transaction.DueDays ?? 0)</DueDays>"
                xmlString  += "<AllValue>\(transaction.AllValue ?? 0.0)</AllValue>"
                xmlString  += "<Longitude>\(transaction.Longitude ?? "0")</Longitude>"
                xmlString  += "<Latitude>\(transaction.Latitude ?? "0")</Latitude>"
                xmlString  += "<ServiceTypeID>\(transaction.ServiceTypeID ?? 0)</ServiceTypeID>"
                xmlString  += "<AssetID>\(transaction.AssetID ?? 0)</AssetID>"
                xmlString  += "<BL>\(transaction.BL ?? false)</BL>"
                xmlString  += "<Memo>\(transaction.Memo ?? "0")</Memo>"
                xmlString  += "<Llogaria_NotaKreditore>\(transaction.Llogaria_NotaKreditore ?? "0")</Llogaria_NotaKreditore>"
                xmlString  += "<Vlera_NotaKreditore>\(transaction.Vlera_NotaKreditore ?? 0.0)</Vlera_NotaKreditore>"
                //            xmlString  += "<Exists></Exists>"
                xmlString  += "<IsPrintFiscalInvoice>\(transaction.IsPrintFiscalInvoice ?? false)</IsPrintFiscalInvoice>"
                //            xmlString  += "<ErrorID></ErrorID>"
                //            xmlString  += "<ErrorDescription></ErrorDescription>"
                xmlString  += "<IsPriceFromPartner>\(transaction.IsPriceFromPartner ?? false)</IsPriceFromPartner>"
                xmlString  += "<NrIFatBlerje>\(transaction.NrIFatBlerje ?? "")</NrIFatBlerje>"
                xmlString  += "<InternalDepartmentID>\(transaction.InternalDepartmentID ?? 0)</InternalDepartmentID>"
                xmlString  += "</XMLTransactions>"
            }
            xmlString  +=  "</Transations>"
        }
        if let safeTransactionDetails = transactionDetails {
            xmlString  +=  "<TransactionDetails>"
            for transactionDetail in safeTransactionDetails {
                xmlString  += "<XMLTransactionDetails>"
                xmlString  += "<ItemID>\(transactionDetail.ItemID ?? "0")</ItemID>"
                xmlString  += "<ItemName>\(transactionDetail.ItemName ?? "")</ItemName>"
                xmlString  += "<Quantity>\(transactionDetail.Quantity ?? 0.0)</Quantity>"
                xmlString  += "<Price>\(transactionDetail.Price ?? 0.0)</Price>"
                xmlString  += "<Value>\(transactionDetail.Value ?? 0.0)</Value>"
                xmlString  += "<TransactionID>\(transactionDetail.TransactionID ?? 0)</TransactionID>"
                xmlString  += "<Rabat>\(transactionDetail.Rabat ?? 0.0)</Rabat>"
                //            xmlString  += "<SubOrderID></SubOrderID>"
                xmlString  += "<Rabat2>\(transactionDetail.Rabat2 ?? 0.0)</Rabat2>"
                xmlString  += "<Rabat3>\(transactionDetail.Rabat3 ?? 0.0)</Rabat3>"
                //            xmlString  += "<Memo></Memo>"
                xmlString  += "<PriceMenuID>\(transactionDetail.PriceMenuID ?? 0)</PriceMenuID>"
                xmlString  += "<Barcode>\(transactionDetail.Barcode ?? "")</Barcode>"
                //            xmlString  += "<AssetID></AssetID>"
                xmlString  += "<UnitID>\(transactionDetail.UnitID ?? 0)</UnitID>"
                xmlString  += "<Coefficient>\(transactionDetail.Coefficient ?? 0.0)</Coefficient>"
                xmlString  += "</XMLTransactionDetails>"
            }
            xmlString  +=  "</TransactionDetails>"
        }
        return xmlString
    }
    
    
    private var parserCompletionhandler: ((UploadResponse) -> Void)?
    
    // me kete funksion dergohen shenimet ne databazen qendore permes web service. 
    func XMLUploadParser(url: String, completionHandler: ((UploadResponse) -> Void)?) {
        
        self.parserCompletionhandler = completionHandler
        let stringBody = buildXMLString(visits: visitsToUpload, transactions: transactionsToUpload, transactionDetails: transactionDetailsToUpload)
        
        let url = URL(string: url)
        let header = ["content-type":"text/xml"]
        let param = """
  <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://www.w3.org/2003/05/soap-envelope">
      <soap:Body>
        <SyncUpload xmlns="http://fina.org/">\(stringBody)</SyncUpload>
    </soap:Body>
  </soap:Envelope>
"""
        let paramTrim =  param.trimmingCharacters(in: .whitespaces)
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = header
        request.httpMethod = "POST"
        request.httpBody = paramTrim.data(using: .utf8)
        request.addValue(String(param.count), forHTTPHeaderField: "Content-Length")
        
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request as URLRequest) { (data, response, error)  in
            if error != nil {
                print("Nuk ka koneksion te internetit")
                
                return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print(response)
                return}
            
            guard let data = data else {  print("Shenimet e kthyera nga web service nuk jane ne format te duhur")
                return }
            // parse xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    // MARK: - XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "SyncUploadResponse" {
            currentSyncUploadResult = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "SyncUploadResult": currentSyncUploadResult += string
            
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "SyncUploadResponse" {
            
            uploadResponse = UploadResponse(SyncUploadResult: currentSyncUploadResult)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        if let safeUploadRespense = uploadResponse {
            parserCompletionhandler?(safeUploadRespense)
        }
        
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}

struct UploadVisit: Codable {
    
    var VisitID: Int
    var BeginningDate: String?
    var PartnerID: Int?
    var EndingDate: String?
    var IsSynchronized: Bool?
    var InsBy: Int?
    var SyncID: Int32?
    var DepartmentID: Int?
    var LongitudeBegin: Double?
    var LongitudeEnd: Double?
    var LatitudeBegin: Double?
    var LatitudeEnd: Double?
    var SetPartnerPosition: Bool?
    var PartnerPicture: Data?
    var SetPartnerPicture: Bool?
    var strPicture: String?
    var UpdatePartnerCoords: Bool?
}

struct UploadResponse: Codable {
    var SyncUploadResult: String?
}

struct UploadTransactions: Codable {
    var TransactionNo: String
    var InvoiceNo: String?
    var TransactionType: Int32?
    var TransactionDate: String?
    var PartnerID: Int32?
    var VisitID: Int32?
    var DepartmentID: Int16?
    var InsDate: String?
    var InsBy: Int32?
    var EmployeeID: Int32?
    var IsSynchronized: Bool?
    var VATPrecentID: Int32?
    var DueDays: Int32?
    var PaymentValue: Double?
    var AllValue: Double?
    var Longitude: String?
    var Latitude: String?
    var ServiceTypeID: Int32?
    var AssetID: Int32?
    var BL: Bool?
    var Memo: String?
    var Llogaria_NotaKreditore: String?
    var Vlera_NotaKreditore: Double?
    //    var Exists: Bool?
    var IsPrintFiscalInvoice: Bool?
    //    var ErrorID: Int?
    //    var ErrorDescription: String?
    var IsPriceFromPartner: Bool?
    var NrIFatBlerje: String?
    var InternalDepartmentID: Int32?
}

struct UploadTransactionDetails: Codable {
    var ItemID: String?
    var ItemName: String?
    var Quantity: Double?
    var Price: Double?
    var Value: Double?
    var TransactionID: Int32?
    var Rabat: Double?
    //    var SubOrderID: Int?
    var Rabat2: Double?
    var Rabat3: Double?
    //    var Memo: String?
    var PriceMenuID: Int16?
    var Barcode: String?
    //    var AssetID: Int?
    var UnitID: Int16?
    var Coefficient: Double?
}



extension Int {
    var boolValue: Bool { return self != 0 }
}



