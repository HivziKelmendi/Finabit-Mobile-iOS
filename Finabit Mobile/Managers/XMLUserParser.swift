//
//  XMLUserParser.swift
//  Finabit Mobile
//
//  Created by Hivzi on 18.2.22.
//

import Foundation

class FeedUserParser: NSObject, XMLParserDelegate {
    
    private var users: [User] = []
    private var currentElement = ""
    private var currentUserID: String = "" {
        didSet {
            currentUserID = currentUserID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentUserName: String = ""{
        didSet {
            currentUserName = currentUserName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentEmployeeID: String = ""{
        didSet {
        currentEmployeeID = currentEmployeeID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentEmployeeName: String = ""{
        didSet {
            currentEmployeeName = currentEmployeeName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDepartmentID: String = ""{
        didSet {
            currentDepartmentID = currentDepartmentID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentOptions: String = ""{
        didSet {
            currentOptions = currentOptions.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentEditTran: String = ""{
        didSet {
            currentEditTran = currentEditTran.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDeleteTran: String = ""{
        didSet {
            currentDeleteTran = currentDeleteTran.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentPDAPIN: String = ""{
        didSet {
            currentPDAPIN = currentPDAPIN.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowSales: String = ""{
        didSet {
            currentAllowSales = currentAllowSales.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowOrder: String = ""{
        didSet {
            currentAllowOrder = currentAllowOrder.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowIn: String = ""{
        didSet {
            currentAllowIn = currentAllowIn.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowOut: String = ""{
        didSet {
            currentAllowOut = currentAllowOut.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowMerchendeiser: String = ""{
        didSet {
            currentAllowMerchendeiser = currentAllowMerchendeiser.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowService: String = ""{
        didSet {
            currentAllowService = currentAllowService.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowAssets: String = ""{
        didSet {
            currentAllowAssets = currentAllowAssets.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowEditRabat: String = ""{
        didSet {
            currentAllowEditRabat = currentAllowEditRabat.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowEditNotaKreditore: String = ""{
        didSet {
            currentAllowEditNotaKreditore = currentAllowEditNotaKreditore.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowEditRabatOrder: String = ""{
        didSet {
            currentAllowEditRabatOrder = currentAllowEditRabatOrder.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowEditPriceOrder: String = ""{
        didSet {
            currentAllowEditPriceOrder = currentAllowEditPriceOrder.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentNavUserName: String = ""{
        didSet {
            currentNavUserName = currentNavUserName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentNavPassword: String = ""{
        didSet {
            currentNavPassword = currentNavPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowInternNew: String = ""{
        didSet {
            currentAllowInternNew = currentAllowInternNew.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentParaqitBorxhinEKons: String = ""{
        didSet {
            currentParaqitBorxhinEKons = currentParaqitBorxhinEKons.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentKufizimiMeCmimbaze: String = ""{
        didSet {
            currentKufizimiMeCmimbaze = currentKufizimiMeCmimbaze.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentLejoLevizjenInterne: String = ""{
        didSet {
            currentLejoLevizjenInterne = currentLejoLevizjenInterne.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentLejoFletehyrjen: String = ""{
        didSet {
            currentLejoFletehyrjen = currentLejoFletehyrjen.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllowFarmersQuantityEdit: String = ""{
        didSet {
            currentAllowFarmersQuantityEdit = currentAllowFarmersQuantityEdit.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentShowScales: String = ""{
        didSet {
            currentShowScales = currentShowScales.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllow_Pranimi_NAV: String = ""{
        didSet {
            currentAllow_Pranimi_NAV = currentAllow_Pranimi_NAV.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentAllow_Dalja_NAV: String = ""{
        didSet {
            currentAllow_Dalja_NAV = currentAllow_Dalja_NAV.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    
    private var parserCompletionhandler: (([User]) -> Void)?
    
    func parseUser(url: String, completionHandler: (([User]) -> Void)?) {
        
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
        if currentElement == "XMLUsers" {
            
            currentUserID = ""
            currentUserName = ""
            currentEmployeeID = ""
            currentEmployeeName = ""
            currentDepartmentID = ""
            currentOptions = ""
            currentEditTran = ""
            currentDeleteTran = ""
            currentPDAPIN = ""
            currentAllowSales = ""
            currentAllowOrder = ""
            currentAllowIn = ""
            currentAllowOut = ""
            currentAllowMerchendeiser = ""
            currentAllowService = ""
            currentAllowAssets = ""
            currentAllowEditRabat = ""
            currentAllowEditNotaKreditore = ""
            currentAllowEditRabatOrder = ""
            currentAllowEditPriceOrder = ""
            currentNavUserName = ""
            currentNavPassword = ""
            currentAllowInternNew = ""
            currentParaqitBorxhinEKons = ""
            currentKufizimiMeCmimbaze = ""
            currentLejoLevizjenInterne = ""
            currentLejoFletehyrjen = ""
            currentAllowFarmersQuantityEdit = ""
            currentShowScales = ""
            currentAllow_Pranimi_NAV = ""
            currentAllow_Dalja_NAV = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "UserID": currentUserID += string
        case "UserName": currentUserName += string
        case "EmployeeID": currentEmployeeID  += string
        case "EmployeeName": currentEmployeeName  += string
        case "DepartmentID": currentDepartmentID  += string
        case "Options": currentOptions  += string
        case "EditTran": currentEditTran  += string
        case "DeleteTran": currentDeleteTran  += string
        case "PDAPIN": currentPDAPIN  += string
        case "AllowSales": currentAllowSales  += string
        case "AllowOrder": currentAllowOrder  += string
        case "AllowIn": currentAllowIn  += string
        case "AllowOut": currentAllowOut  += string
        case "AllowMerchendeiser": currentAllowMerchendeiser  += string
        case "AllowService": currentAllowService  += string
        case "AllowAssets": currentAllowAssets  += string
        case "AllowEditRabat": currentAllowEditRabat  += string
        case "AllowEditNotaKreditore": currentAllowEditNotaKreditore  += string
        case "AllowEditRabatOrder": currentAllowEditRabatOrder  += string
        case "AllowEditPriceOrder": currentAllowEditPriceOrder  += string
        case "NavUserName": currentNavUserName  += string
        case "NavPassword": currentNavPassword  += string
        case "AllowInternNew": currentAllowInternNew  += string
        case "ParaqitBorxhinEKons": currentParaqitBorxhinEKons  += string
        case "KufizimiMeCmimbaze": currentKufizimiMeCmimbaze  += string
        case "LejoLevizjenInterne": currentLejoLevizjenInterne  += string
        case "LejoFletehyrjen": currentLejoFletehyrjen  += string
        case "AllowFarmersQuantityEdit": currentAllowFarmersQuantityEdit  += string
        case "ShowScales": currentShowScales  += string
        case "Allow_Pranimi_NAV": currentAllow_Pranimi_NAV  += string
        case "Allow_Dalja_NAV": currentAllow_Dalja_NAV  += string
        default: break
        }
    }
    // test
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "XMLUsers" {
           

            let user = User(UserID: Int(currentUserID), UserName: currentUserName, EmployeeID: Int(currentEmployeeID), EmployeeName: currentEmployeeName, DepartmentID: Int(currentDepartmentID), Options: currentOptions, EditTran: currentEditTran, DeleteTran: currentDeleteTran, PDAPIN: Int(currentPDAPIN), AllowSales: currentAllowSales, AllowOrder: currentAllowOrder, AllowIn: currentAllowIn, AllowOut: currentAllowOut, AllowMerchendeiser: currentAllowMerchendeiser, AllowService: currentAllowService, AllowAssets: currentAllowAssets, AllowEditRabat: currentAllowEditRabat, AllowEditNotaKreditore: currentAllowEditNotaKreditore, AllowEditRabatOrder: currentAllowEditRabatOrder, AllowEditPriceOrder: currentAllowEditPriceOrder, NavUserName: currentNavUserName, NavPassword: currentNavPassword, AllowInternNew: currentAllowInternNew, ParaqitBorxhinEKons: currentParaqitBorxhinEKons, KufizimiMeCmimbaze: currentKufizimiMeCmimbaze, LejoLevizjenInterne: currentLejoLevizjenInterne, LejoFletehyrjen: currentLejoFletehyrjen, AllowFarmersQuantityEdit: currentAllowFarmersQuantityEdit, ShowScales: currentShowScales, Allow_Pranimi_NAV: currentAllow_Pranimi_NAV, Allow_Dalja_NAV: currentAllow_Dalja_NAV)
            self.users.append(user)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionhandler?(users)
        users.removeAll()
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

