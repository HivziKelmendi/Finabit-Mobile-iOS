//
//  ClientsVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 22.3.22.
//

import UIKit

class ClientVC: UIViewController {
    
    var completionHandler: ((PartnerInSqLite) -> Void)?
    
    var clients: [PartnerInSqLite?] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        fetchPartner()
    }
    
    private func fetchPartner() {
        PersistenceManager.shared.fetchingPartnerFromSqLite {[weak self] result in
            switch result {
            case .success(let partners):
                self?.clients = partners
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ClientVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClientCell", for: indexPath)  as? ClientCell else {return UITableViewCell()}
        
        DispatchQueue.main.async
        {
            guard  let client = self.clients[indexPath.row] else {return}
            cell.updateCell(from: client)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "ClientToVisit", sender: self)
        guard let client = clients[indexPath.row] else {return}
        if  completionHandler != nil {
            completionHandler!(client)
            dismiss(animated: true, completion: nil)
        } else {
            print("ska kliente")
        }
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let destinationVC = segue.destination as! VisitVC
    //        if segue.identifier == "ClientToVisit" {
    //            if let indexPath = tableView.indexPathForSelectedRow {
    //                let client = clients[indexPath.row]
    //                destinationVC.chosenClient = client
    //            }
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 90
        return cellHeight
    }
}
