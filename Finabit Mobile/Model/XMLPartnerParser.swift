//
//  XMLPartnerParser.swift
//  Finabit Mobile
//
//  Created by Hivzi on 9.3.22.
//

import Foundation

struct Partner: Codable {
    var PartnerID: Int?
    var PartnerName: String?
    var PartnerBarcode: Double?
    var PartnerRegion: Int?
    var DueDays: Int?
    var DueValue: Double?
    var DueValueMaximum: Double?
    var Longitude: Double?
    var Latitude: Double?
    var FiscalNo: String?
    var BusinessNo: String?
    var Address: String?
    var DiscountPercent: Double?
    var DiscountLevel: Int?
    var PlaceName: String?
    var ItemID: Int?
    var MinimumValueForDiscount: Int?
    var DiscountPercent2: Int?
    var RouteOrderID: Int?
    var Day: Int?
    var MerchSecondaryPlacement: Int?
    var MerchDescription: Int?
    var DefaultPartner: String?
    var VatNo: String?
    var OwnerName: String?
    var PricemenuID: Int?
    var PartnerTypeID: Int?
}

class FeedPartnerParser: NSObject, XMLParserDelegate  {
    
    private var partners: [Partner] = []
    private var currentElement = ""
    
    private var currentPartnerID: String = "" {
        didSet {
            currentPartnerID = currentPartnerID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPartnerName: String = ""{
        didSet {
            currentPartnerName = currentPartnerName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPartnerBarcode: String = ""{
        didSet {
            currentPartnerBarcode = currentPartnerBarcode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentPartnerRegion: String = ""{
        didSet {
            currentPartnerRegion = currentPartnerRegion.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDueDays: String = ""{
        didSet {
            currentDueDays = currentDueDays.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDueValue: String = ""{
        didSet {
            currentDueValue = currentDueValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDueValueMaximum: String = ""{
        didSet {
            currentDueValueMaximum = currentDueValueMaximum.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentLongitude: String = ""{
        didSet {
            currentLongitude = currentLongitude.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentLatitude: String = ""{
        didSet {
            currentLatitude = currentLatitude.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentFiscalNo: String = ""{
        didSet {
            currentFiscalNo = currentFiscalNo.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentBusinessNo: String = ""{
        didSet {
            currentBusinessNo = currentBusinessNo.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAddress: String = ""{
        didSet {
            currentAddress = currentAddress.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDiscountPercent: String = ""{
        didSet {
            currentDiscountPercent = currentDiscountPercent.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDiscountLevel: String = ""{
        didSet {
            currentDiscountLevel = currentDiscountLevel.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentPlaceName: String = ""{
        didSet {
            currentPlaceName = currentPlaceName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentItemID: String = ""{
        didSet {
            currentItemID = currentItemID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentMinimumValueForDiscount: String = ""{
        didSet {
            currentMinimumValueForDiscount = currentMinimumValueForDiscount.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDiscountPercent2: String = ""{
        didSet {
            currentDiscountPercent2 = currentDiscountPercent2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentRouteOrderID: String = ""{
        didSet {
            currentRouteOrderID = currentRouteOrderID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDay: String = ""{
        didSet {
            currentDay = currentDay.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }

    private var currentMerchSecondaryPlacement: String = ""{
        didSet {
            currentMerchSecondaryPlacement = currentMerchSecondaryPlacement.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }

    private var currentMerchDescription: String = ""{
        didSet {
            currentMerchDescription = currentMerchDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }

    private var currentDefaultPartner: String = ""{
        didSet {
            currentDefaultPartner = currentDefaultPartner.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }

    private var currentVatNo: String = ""{
        didSet {
            currentVatNo = currentVatNo.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentOwnerName: String = ""{
        didSet {
            currentOwnerName = currentOwnerName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentPricemenuID: String = ""{
        didSet {
            currentPricemenuID = currentPricemenuID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentPartnerTypeID: String = ""{
        didSet {
            currentPartnerTypeID = currentPartnerTypeID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    
    
     
    private var parserCompletionhandler: (([Partner]) -> Void)?
    
    func parsePartner(url: String, completionHandler: (([Partner]) -> Void)?) {
        
        self.parserCompletionhandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error)  in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
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
        if currentElement == "XMLPartners" {
            currentPartnerID = ""
            currentPartnerName = ""
            currentPartnerBarcode = ""
            currentPartnerRegion = ""
            currentDueDays = ""
            currentDueValue = ""
            currentDueValueMaximum = ""
            currentLongitude = ""
            currentLatitude = ""
            currentFiscalNo = ""
            currentBusinessNo = ""
            currentAddress = ""
            currentDiscountPercent = ""
            currentDiscountLevel = ""
            currentPlaceName = ""
            currentItemID = ""
            currentMinimumValueForDiscount = ""
            currentDiscountPercent2 = ""
            currentRouteOrderID = ""
            currentDay = ""
            currentMerchSecondaryPlacement = ""
            currentMerchDescription = ""
            currentDefaultPartner = ""
            currentVatNo = ""
            currentOwnerName = ""
            currentPricemenuID = ""
            currentPartnerTypeID = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "PartnerID": currentPartnerID += string
        case "PartnerName": currentPartnerName += string
        case "PartnerBarcode": currentPartnerBarcode  += string
        case "PartnerRegion": currentPartnerRegion  += string
        case "DueDays ": currentDueDays  += string
        case "DueValue": currentDueValue  += string
        case "DueValueMaximum": currentDueValueMaximum  += string
        case "Longitude": currentLongitude += string
        case "Latitude": currentLatitude += string
        case "FiscalNo": currentFiscalNo  += string
        case "Address": currentAddress  += string
        case "DiscountPercent": currentDiscountPercent  += string
        case "DiscountLevel": currentDiscountLevel  += string
        case "PlaceName": currentPlaceName  += string
        case "ItemID": currentItemID  += string
        case "MinimumValueForDiscount": currentMinimumValueForDiscount  += string
        case "DiscountPercent2": currentDiscountPercent2  += string
        case "RouteOrderID": currentRouteOrderID  += string
        case "Day": currentDay  += string
        case "MerchSecondaryPlacement": currentMerchSecondaryPlacement  += string
        case "MerchDescription": currentMerchDescription  += string
        case "DefaultPartner": currentDefaultPartner  += string
        case "VatNo": currentVatNo  += string
        case "OwnerName": currentOwnerName  += string
        case "PricemenuID": currentPricemenuID  += string
        case "PartnerTypeID": currentPartnerTypeID  += string

        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "XMLPartners" {
           
          let partner = Partner(PartnerID: Int(currentItemID), PartnerName: currentPartnerName, PartnerBarcode: Double(currentPartnerBarcode), PartnerRegion: Int(currentPartnerRegion), DueDays: Int(currentDueDays), DueValue: Double(currentDueValue), DueValueMaximum: Double(currentDueValueMaximum), Longitude: Double(currentLatitude), Latitude: Double(currentLatitude), FiscalNo: currentFiscalNo, BusinessNo: currentBusinessNo, Address: currentAddress, DiscountPercent: Double(currentDiscountPercent), DiscountLevel: Int(currentDiscountLevel), PlaceName: currentPlaceName, ItemID: Int(currentItemID), MinimumValueForDiscount: Int(currentMinimumValueForDiscount), DiscountPercent2: Int(currentDiscountPercent2), RouteOrderID: Int(currentRouteOrderID), Day: Int(currentDay), MerchSecondaryPlacement: Int(currentMerchSecondaryPlacement), MerchDescription: Int(currentMerchDescription), DefaultPartner: currentDefaultPartner, VatNo: currentVatNo, OwnerName: currentOwnerName, PricemenuID: Int(currentPricemenuID), PartnerTypeID: Int(currentPartnerTypeID))
            self.partners.append(partner)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionhandler?(partners)
        partners.removeAll()
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
