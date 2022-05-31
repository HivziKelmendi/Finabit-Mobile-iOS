//
//  LocalSettingsVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 3.3.22.
//

import UIKit

class LocalSettingsVC: UIViewController {
    
    @IBOutlet weak var departmentPicker: UIPickerView!
   public var selectedDepartmentID: String = ""
    public var defaultDepartment: String?
    
    public var  dafaultDepartment: String?
    private var items: [Item]?
    private var partners: [Partner]?

    private let baseItemUrl = Constants.baseItemUrl
    private var basePartnerUrl = Constants.basePartnerUrl
    
    let feedItemParser = FeedItemParser()
    let feedPartnerParser = FeedPartnerParser()
    private var departments: [DepartmentInSqlite] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        departmentPicker.dataSource = self
        departmentPicker.delegate = self
        fetchDepartments()
    }
    
    @IBAction func saveSettings(_ sender: UIBarButtonItem) {
        let itemsEndpoint = baseItemUrl + selectedDepartmentID
        feedItemParser.parseItem(url: itemsEndpoint) { items in
            self.items = items
           
            PersistenceManager.shared.addItemToCoreData(items: items) { result in
                switch result {
                case .success():
                    print("Sukses")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        let partnersEndpoint = basePartnerUrl + selectedDepartmentID
        feedPartnerParser.parsePartner(url: partnersEndpoint) { partners in
            self.partners = partners
            
          PersistenceManager.shared.addPartnerToCoreData(partners: partners) { result in
              switch result {
              case .success():
                  DispatchQueue.main.async {
                      let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                  }
              case .failure(let error):
                   print(error.localizedDescription)
               }
           }
      }
    }
    
    
    private func fetchDepartments() {
        
        PersistenceManager.shared.fetchingDepartmentFromSqLite {[weak self] result in
            switch result {
            case .success(let departments):
                self?.departments = departments
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension LocalSettingsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        departments.count
    }
  
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let selectedDepartment = departments[row].departmentName
        return selectedDepartment
    }
   
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         selectedDepartmentID = String(departments[row].departmentID)
        UDM.shared.defaults.set(selectedDepartmentID, forKey: "defaultDepartment")
    }
}

