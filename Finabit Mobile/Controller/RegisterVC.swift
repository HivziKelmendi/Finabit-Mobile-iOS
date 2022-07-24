//
//  RegisterVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 13.2.22.
//

import UIKit

class RegisterVC: UIViewController {

    
    private var users: [User]?
    private var departments: [Department]?
    private let baseUsersUrl = Constants.baseUsersUrl
    private let baseDepartmentUrl = Constants.baseDepartmentUrl
    private var usersSaved = false
    private var departmentsSaved = false
    

    let xmlUserParser = FeedUserParser()
    let xmlDepartmentParser = FeedDepartmenParser()
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField?.delegate = self
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        textField.endEditing(true)
    }
    
    func showSuccessAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Verejtje", message: "Shenimet jane ruajtur me sukses", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                self.performSegue(withIdentifier: "RegisterToLogin", sender: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true) }
}
    
    func showfailureAlert() {
        DispatchQueue.main.async {

            let alert = UIAlertController(title: "Verejtje", message: "Shenimet  nuk jane ruajtur", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true) }
  }
}

extension RegisterVC: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = " Shkruaje IP-në e servisit"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let safeIpAddress = textField.text {
            
            let usersEndpoint = "http://\(safeIpAddress)\(baseUsersUrl)"
            let departmentsEndpoint = "http://\(safeIpAddress)\(baseDepartmentUrl)"
            
            xmlUserParser.parseUser(url: usersEndpoint) { (users) in
                self.users = users
                PersistenceManager.shared.addUsersToCoreData(users: users) { result in
                    switch result {
                    case .success():
                        self.usersSaved = true
                    case .failure(let error):
                        self.usersSaved = false                    }
                }
            }
            
            xmlDepartmentParser.parseDepartment(url: departmentsEndpoint) { (departments) in
                self.departments = departments
                PersistenceManager.shared.addDepartmentsToCoreData(departments: departments) {result in
                    switch result {
                    case .success():
                        self.departmentsSaved = true
                        if self.usersSaved && self.departmentsSaved == true {
                            self.showSuccessAlert()
                        }
                      
                    case .failure(let error):
                        self.usersSaved = false
                        if self.usersSaved || self.departmentsSaved == false {
                            self.showfailureAlert()
                        }
                    }
                }
            }
        }
        textField.text = ""
            
    }
}
