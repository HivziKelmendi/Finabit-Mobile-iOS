//
//  ViewController.swift
//  Finabit Mobile
//
//  Created by Hivzi on 13.2.22.
//

import UIKit

class EntryVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//                PersistenceManager.shared.DeleteUserInSqLite()
//                PersistenceManager.shared.DeleteDepartmentInSqLite()
        //        PersistenceManager.shared.DeleteVisitInSqLite()
        //        PersistenceManager.shared.DeleteTransactionInSqLite()
        //        PersistenceManager.shared.DeleteTransactionDetailsInSqLite()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    // me kodin e meposhtem mundesohet te fshehet navigation ne EntryVC
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
    }
}

