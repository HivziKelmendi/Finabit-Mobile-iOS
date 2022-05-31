//
//  XMLItemParser.swift
//  Finabit Mobile
//
//  Created by Hivzi on 6.3.22.
//

import Foundation

struct Item : Codable {
    
    var ItemID: String?
    var ItemName: String?
    var Quantity: String?
    var Price: Double?
    var DepartmentID: Int?
    var Rabat: Double?
    var Barcode: String?
    var Gratis: String?
    var Coefficient: Double?
    var VATValue: Double?
    var ItemGroupID: Int?
    var UnitName: String?
    var Unit1Default: String?
    var Coef_Quantity: Double?
    var MinimalPrice: Double?
    var Discount: Double?
    var IncludeInTargetPlan: String?
    var ID: Int?
    var PriceMenuID: Int?
    var NotaKreditore: Double?
    var CustomField6: String?
    var ItemGroupName: String?
    var UnitID1: Int?
    var UnitID2: Int?
    var UnitName1: String?
    var UnitName2: String?
    var MinimumQuantity: Int?

}

class FeedItemParser: NSObject, XMLParserDelegate  {
    
    private var items: [Item] = []
    private var currentElement = ""
    
    private var currentItemID: String = "" {
        didSet {
            currentItemID = currentItemID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentItemName: String = ""{
        didSet {
            currentItemName = currentItemName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentQuantity: String = ""{
        didSet {
            currentQuantity = currentQuantity.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentPrice: String = ""{
        didSet {
            currentPrice = currentPrice.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDepartmentID: String = ""{
        didSet {
            currentDepartmentID = currentDepartmentID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentRabat: String = ""{
        didSet {
            currentRabat = currentRabat.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentBarcode: String = ""{
        didSet {
            currentBarcode = currentBarcode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentGratis: String = ""{
        didSet {
            currentGratis = currentGratis.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentCoefficient: String = ""{
        didSet {
            currentCoefficient = currentCoefficient.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentVATValue: String = ""{
        didSet {
            currentVATValue = currentVATValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentItemGroupID: String = ""{
        didSet {
            currentItemGroupID = currentItemGroupID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentUnitName: String = ""{
        didSet {
            currentUnitName = currentUnitName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentUnit1Default: String = ""{
        didSet {
            currentUnit1Default = currentUnit1Default.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentCoef_Quantity: String = ""{
        didSet {
            currentCoef_Quantity = currentCoef_Quantity.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentMinimalPrice: String = ""{
        didSet {
            currentMinimalPrice = currentMinimalPrice.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDiscount: String = ""{
        didSet {
            currentDiscount = currentDiscount.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentIncludeInTargetPlan: String = ""{
        didSet {
            currentIncludeInTargetPlan = currentIncludeInTargetPlan.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentID: String = ""{
        didSet {
            currentID = currentID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentPriceMenuID: String = ""{
        didSet {
            currentPriceMenuID = currentPriceMenuID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentNotaKreditore: String = ""{
        didSet {
            currentNotaKreditore = currentNotaKreditore.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentCustomField6: String = ""{
        didSet {
            currentCustomField6 = currentCustomField6.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentItemGroupName: String = ""{
        didSet {
            currentItemGroupName = currentItemGroupName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentUnitID1: String = ""{
        didSet {
            currentUnitID1 = currentUnitID1.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentUnitID2: String = ""{
        didSet {
            currentUnitID2 = currentUnitID2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentUnitName1: String = ""{
        didSet {
            currentUnitName1 = currentUnitName1.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentUnitName2: String = ""{
        didSet {
            currentUnitName2 = currentUnitName2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentMinimumQuantity: String = ""{
        didSet {
            currentMinimumQuantity = currentMinimumQuantity.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
  
    
     
    private var parserCompletionhandler: (([Item]) -> Void)?
    
    func parseItem(url: String, completionHandler: (([Item]) -> Void)?) {
        
        self.parserCompletionhandler = completionHandler
        
//         let request = URLRequest(url: URL(string: url)!)
//        let urlSession = URLSession.shared
//        let task = urlSession.dataTask(with: request) { (data, response, error)  in
//            guard let data = data else {
//                if let error = error {
//                    print("ska shenime")
//                }
//                return
//            }
//
            guard let url = URL(string: url)  else { return }
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?)  in
                 if error != nil {
                     print(error!)
                     
                     return }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return}
                     
            guard let data = data else {  print("Ska shenime")
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
        if currentElement == "XMLItems" {
            currentItemID = ""
            currentItemName = ""
            currentQuantity = ""
            currentPrice = ""
            currentDepartmentID = ""
            currentRabat = ""
            currentGratis = ""
            currentCoefficient = ""
            currentVATValue = ""
            currentItemGroupID = ""
            currentUnitName = ""
            currentUnit1Default = ""
            currentCoef_Quantity = ""
            currentMinimalPrice = ""
            currentDiscount = ""
            currentIncludeInTargetPlan = ""
            currentID = ""
            currentPriceMenuID = ""
            currentNotaKreditore = ""
            currentCustomField6 = ""
            currentItemGroupName = ""
            currentUnitID1 = ""
            currentUnitID2 = ""
            currentUnitName1 = ""
            currentUnitName2 = ""
            currentMinimumQuantity = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "ItemID": currentItemID += string
        case "ItemName": currentItemName += string
        case "Quantity": currentQuantity  += string
        case "Price": currentPrice  += string
        case "DepartmentID": currentDepartmentID  += string
        case "Rabat": currentRabat  += string
        case "Coefficient": currentCoefficient  += string
        case "VATValue": currentVATValue  += string
        case "ItemGroupID": currentItemGroupID  += string
        case "UnitName": currentUnitName  += string
        case "Unit1Default": currentUnit1Default  += string
        case "Coef_Quantity": currentCoef_Quantity  += string
        case "MinimalPrice": currentMinimalPrice  += string
        case "Discount": currentDiscount  += string
        case "IncludeInTargetPlan": currentIncludeInTargetPlan  += string
        case "ID": currentID  += string
        case "PriceMenuID": currentPriceMenuID  += string
        case "NotaKreditore": currentNotaKreditore  += string
        case "CustomField6": currentCustomField6  += string
        case "ItemGroupName": currentItemGroupName  += string
        case "UnitID1": currentUnitID1  += string
        case "UnitID1": currentUnitID2  += string
        case "UnitName1": currentUnitName1  += string
        case "UnitName2": currentUnitName2  += string
        case "MinimumQuantity": currentMinimumQuantity  += string         
            
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "XMLItems" {
           
            let item = Item(ItemID: currentItemID, ItemName: currentItemName, Quantity: currentQuantity, Price: Double(currentPrice), DepartmentID: Int(currentDepartmentID), Rabat: Double(currentRabat), Barcode: currentBarcode, Gratis: currentGratis, Coefficient: Double(currentCoefficient), VATValue: Double(currentVATValue), ItemGroupID: Int(currentItemGroupID), UnitName: currentUnitName, Unit1Default: currentUnit1Default, Coef_Quantity: Double(currentCoef_Quantity), MinimalPrice: Double(currentMinimalPrice), Discount: Double(currentDiscount), IncludeInTargetPlan: currentIncludeInTargetPlan, ID: Int(currentID), PriceMenuID: Int(currentPriceMenuID), NotaKreditore: Double(currentNotaKreditore), CustomField6: currentCustomField6, ItemGroupName: currentItemGroupID, UnitID1: Int(currentUnitID1), UnitID2: Int(currentUnitID2), UnitName1: currentUnitName1, UnitName2: currentUnitName2, MinimumQuantity: Int(currentMinimumQuantity))
            self.items.append(item)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionhandler?(items)
        items.removeAll()
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
