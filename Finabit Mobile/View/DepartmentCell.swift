//
//  DepartmentCell.swift
//  Finabit Mobile
//
//  Created by Hivzi on 30.3.22.
//

import UIKit

class DepartmentCell: UITableViewCell {
    @IBOutlet weak var departmentName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(from department: DepartmentInSqlite) {
        
        self.departmentName.text = department.departmentName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
