//
//  LocalSettingsVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 3.3.22.
//

import UIKit

class LocalSettingsVC: UIViewController {
    
    @IBOutlet weak var departmentPicker: UIPickerView!
    var selectedDepartmentID: String = ""
    var defaultDepartment: String?
    var  dafaultDepartment: String?
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
    
    override func viewWillDisappear(_ animated: Bool) {
      
                
    }
    // pasi eshte zgjedhur departmenti, per departmentin e caktuar nga web service, merren partneret dhe items, si dhe ruhen ne CoreData
    @IBAction func saveSettings(_ sender: UIBarButtonItem) {
        let waitingScreen = self.waitingScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                self.stopwaitingScreen(loader: waitingScreen)
            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController
          
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
        let itemsEndpoint = baseItemUrl + selectedDepartmentID
        feedItemParser.parseItem(url: itemsEndpoint) { items in
            self.items = items
            PersistenceManager.shared.addItemToCoreData(items: items) { result in
                switch result {
                case .success():
                    print("Sukses")
                case .failure(let error):
                    print("items nuk jane ruajtur me sukses")
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
                      
                    }
                case .failure(let error):
                    print("partneret nuk jane ruajtur me sukses")
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

// ne PickerView selektohet departmenti dhe ruhet ne UserDefault

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

