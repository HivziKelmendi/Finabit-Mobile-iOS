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
        NotificationCenter.default.addObserver(forName: NSNotification.Name("true"), object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
        numriITransaksionit = transactions.count
        vleraETransLabel.text = String(format: "%.1f", vleraETransactionit)
        numriITransLabel.text = String(numriITransaksionit ?? 0)
        
    }
    // merren transaksionet nga CoreData dhe mbushet tableView si dhe paraqiten numri dhe vlera e transaksioneve per ate dite
    public func fetchItems() {
        PersistenceManager.shared.fetchingOrderTransactionsByDate { [self] result in
            switch result {
            case .success(let transactionsFromSqLite):
                self.transactions = transactionsFromSqLite
                tableView.reloadData()
                vleraETransactionit = 0
                for transaction in transactions {
                    if transaction != nil {
                        vleraETransactionit += transaction.allValue
                    }
                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 16) {
//                    self.tableView.reloadData()
//                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // merret vizita e fundit nga CoreData dhe shikohet a ka vizite te hapur paraprakisht(dmth qe e ka endingDate nil). Nese  endingData eshte nil por edhe visitId eshte nil, nenkupton qe nuk ka te ruajtur asnje vizite ne CoreData dhe hapet vizite e re. Nese vizitId nuk eshte nil por endingData eshte nil, nenkupton qe ka vizite te hapur, dhe kalohet te porosite. Opsioni i trete mbetet qe te kalohet te vizita e re.
    @IBAction func newOrderPressed(_ sender: UIButton) {
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        
        do {
            lastVisit =  try context.fetch(request).last
        } catch {
        }
        if lastVisit?.endingDate == nil && lastVisit?.visitId == nil {
            self.performSegue(withIdentifier: "OrdersToVisit", sender: nil)
        }
        else if lastVisit?.endingDate == nil && lastVisit?.visitId != nil {
            self.performSegue(withIdentifier: "OrdersToNewOrder", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "OrdersToVisit", sender: nil)
        }
    }
    
    // qe te dihet se a hapet vizita nga shitjet apo porosite, dergohet transacionType. TransactionType e porosive eshte 15, kurse per shitjet 2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? NewOrderVC
        let destinationVC1 = segue.destination as? VisitVC
        if segue.identifier == "OrdersToNewOrder"  {
            destinationVC?.transactionType = 15
        }
        else  {
            destinationVC1?.transactionTypeInVisit = 15
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
