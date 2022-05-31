//
//  ItemVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 17.3.22.
//

import UIKit

class ItemVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items: [ItemInSqLite] = []
    var completionHandler: ((ItemInSqLite) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        fetchItems()
    }
    private func fetchItems() {
        
        PersistenceManager.shared.fetchingItemFromSqLite {[weak self] result in
            switch result {
            case .success(let items):
                self?.items = items
                print(items.count)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ItemVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)  as? ItemCell else {return UITableViewCell()}
        
        DispatchQueue.main.async
        {
            let item = self.items[indexPath.row]
            cell.updateCell(from: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let item = items[indexPath.row]
       
            completionHandler!(item)
        dismiss(animated: true, completion: nil)
      
//        performSegue(withIdentifier: "ItemToNewOrderVC", sender: self)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! NewOrderVC
//        if segue.identifier == "ItemToNewOrderVC" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let item = items[indexPath.row]
//                destinationVC.chosenItem = item
//
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 90
        return cellHeight
    }
}
