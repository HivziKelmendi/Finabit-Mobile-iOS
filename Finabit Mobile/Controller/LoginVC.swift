//
//  LoginVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 13.2.22.
//

import UIKit
import CoreData


class LoginVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   var localSettingsVC = LocalSettingsVC()
    var user: [UserInSqLite] = []
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UDM.shared.del
    }
    

}
extension LoginVC: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return}
        let request : NSFetchRequest<UserInSqLite> = UserInSqLite.fetchRequest()
        let predicate = NSPredicate(format: "userID CONTAINS[cd] %@", text)
        request.predicate = predicate
//        request.fetchLimit = 1
        
//        let sort = NSSortDescriptor(key: "userID", ascending: true)
//        request.sortDescriptors = [sort]
        
        do {
            let defaultDepartment = UDM.shared.defaults.value(forKey: "defaultDepartment") as? String
           let user =  try context.fetch(request)
            print(user.count)
            let ind = 0
            if ind < user.count {
                if String(user[ind].userID) == text && defaultDepartment  == nil {
                self.performSegue(withIdentifier: "LoginToLocalSettings", sender: nil)
            }
            else if String(user[ind].userID) == text && defaultDepartment  != nil
            {
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                
            }
            else {
            }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
