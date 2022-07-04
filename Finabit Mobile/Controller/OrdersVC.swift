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

    @IBOutlet weak var vleraETransLabel: UILabel!
    @IBOutlet weak var numriITransLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var transactions: [TransactionInSqLite] = []
    private var vleraETransactionit: Double = 0.0
    private var numriITransaksionit: Int?
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate =  self
       
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numriITransaksionit = transactions.count
        vleraETransLabel.text = String(format: "%.1f", vleraETransactionit)
        numriITransLabel.text = String(numriITransaksionit ?? 0)
        fetchItems()
    }
   
    private func fetchItems() {
        PersistenceManager.shared.fetchingTransactionsByDate { [self] result in
            switch result {
            case .success(let transactionsFromSqLite):                
                self.transactions = transactionsFromSqLite
                self.tableView.reloadData()
                vleraETransactionit = 0
                for transaction in transactions {
                    if transaction != nil {
                        vleraETransactionit += transaction.allValue
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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


extension OrdersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)  as? OrderCell else {return UITableViewCell()}
        
        DispatchQueue.main.async
        {
            let transactions = self.transactions[indexPath.row]
            cell.updateTransactionInVisits(from: transactions)

        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 90
        return cellHeight
    }
}
