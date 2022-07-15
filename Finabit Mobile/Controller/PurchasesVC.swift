//
//  PurchasesVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 7.7.22.
//

import UIKit
import CoreData
class PurchasesVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var lastVisit: VisitInSqLite?
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
        PersistenceManager.shared.fetchingPurcheasTransactionsByDate { [self] result in
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
    
    
    @IBAction func newPurchasesPressed(_ sender: UIButton) {
                let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        
                do {
                     lastVisit =  try context.fetch(request).last
        
                } catch {
             }
                if lastVisit?.endingDate == nil && lastVisit?.visitId == nil {
                    self.performSegue(withIdentifier: "PurchasesToVisit", sender: nil)
                }
                else if lastVisit?.endingDate == nil && lastVisit?.visitId != nil {
                    self.performSegue(withIdentifier: "PurchasesToNewOrder", sender: nil)
                }
        
                else {
                    self.performSegue(withIdentifier: "PurchasesToVisit", sender: nil)
                }
    }
      

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let destinationVC = segue.destination as? NewOrderVC
        let destinationVC1 = segue.destination as? VisitVC
         if segue.identifier == "PurchasesToNewOrder"  {
             destinationVC?.transactionType = 2
         }
        else  {
            destinationVC1?.transactionTypeInVisit = 2
        }
    }
}

extension PurchasesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PurcheaseCell", for: indexPath)  as? OrderCell else {return UITableViewCell()}
        
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
