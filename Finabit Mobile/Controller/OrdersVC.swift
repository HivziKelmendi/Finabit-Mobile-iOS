//
//  OrdersVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 27.3.22.
//

import UIKit
import CoreData

class OrdersVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    
    @IBAction func newOrderPressed(_ sender: UIButton) {
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()

        do {
            let lastVisit =  try context.fetch(request).last
            if lastVisit?.endingDate == nil && lastVisit?.visitId == nil {
                self.performSegue(withIdentifier: "OrdersToVisit", sender: nil)
            }
            else if lastVisit?.endingDate == nil && lastVisit?.visitId != nil {
                self.performSegue(withIdentifier: "OrdersToNewOrder", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "OrdersToVisit", sender: nil)
            }
        } catch {
     }
   }
    
}
