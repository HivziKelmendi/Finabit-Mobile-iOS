//
//  XMLDepartmenParser.swift
//  Finabit Mobile
//
//  Created by Hivzi on 20.2.22.
//

import Foundation

struct Department: Codable {
    
    var DepartmentID: Int?
    var DepartmentName: String?
    var AllowNegative: String?
    var ShowRoutes: Int?
    var StartCount: String?
    var EndCount: String?
    var DownloadPartnersByDepartment: String?
}

class FeedDepartmenParser: NSObject, XMLParserDelegate  {
    
    private var departmens: [Department] = []
    private var currentElement = ""
    
    private var currentDepartmentID: String = "" {
        didSet {
            currentDepartmentID = currentDepartmentID.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDepartmentName: String = ""{
        didSet {
            currentDepartmentName = currentDepartmentName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentAllowNegative: String = ""{
        didSet {
            currentAllowNegative = currentAllowNegative.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentShowRoutes: String = ""{
        didSet {
            currentShowRoutes = currentShowRoutes.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentStartCount: String = ""{
        didSet {
            currentStartCount = currentStartCount.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentEndCount: String = ""{
        didSet {
            currentEndCount = currentEndCount.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
    private var currentDownloadPartnersByDepartment: String = ""{
        didSet {
            currentDownloadPartnersByDepartment = currentDownloadPartnersByDepartment.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       }
    }
     
    private var parserCompletionhandler: (([Department]) -> Void)?
    
    func parseDepartment(url: String, completionHandler: (([Department]) -> Void)?) {
        
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
        if currentElement == "Departments" {
            currentDepartmentID = ""
            currentDepartmentName = ""
            currentAllowNegative = ""
            currentShowRoutes = ""
            currentStartCount = ""
            currentEndCount = ""
            currentDownloadPartnersByDepartment = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "DepartmentID": currentDepartmentID += string
        case "DepartmentName": currentDepartmentName += string
        case "AllowNegative": currentAllowNegative  += string
        case "ShowRoutes": currentShowRoutes  += string
        case "StartCount": currentStartCount  += string
        case "EndCount": currentEndCount  += string
        case "DownloadPartnersByDepartment": currentDownloadPartnersByDepartment  += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Departments" {
           
          let department = Department(DepartmentID: Int(currentDepartmentID), DepartmentName: currentDepartmentName, AllowNegative: currentAllowNegative, ShowRoutes: Int(currentShowRoutes), StartCount: currentStartCount, EndCount: currentEndCount, DownloadPartnersByDepartment: currentDownloadPartnersByDepartment)
            self.departmens.append(department)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionhandler?(departmens)
        departmens.removeAll()
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
