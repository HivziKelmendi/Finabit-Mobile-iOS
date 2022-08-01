//
//  DepartmentVC.swift
//  Finabit Mobile
//
//  Created by Hivzi on 30.3.22.
//

import UIKit

class DepartmentVC: UIViewController {
    var departments: [DepartmentInSqlite] = []
    var completionHandler: ((DepartmentInSqlite) -> Void)?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        fetchDepartment()
    }
    private func fetchDepartment() {
        PersistenceManager.shared.fetchingDepartmentFromSqLite {[weak self] result in
            switch result {
            case .success(let departments):
                self?.departments = departments
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension DepartmentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        departments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DepartmentCell", for: indexPath)  as? DepartmentCell else {return UITableViewCell()}
        
        DispatchQueue.main.async
        {
            let department = self.departments[indexPath.row]
            cell.updateCell(from: department)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let department = departments[indexPath.row]
        completionHandler!(department)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 50
        return cellHeight
    }
}
