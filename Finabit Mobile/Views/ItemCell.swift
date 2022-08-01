//
//  ItemCell.swift
//  Finabit Mobile
//
//  Created by Hivzi on 17.3.22.
//

import UIKit

class ItemCell: UITableViewCell {
 
    @IBOutlet weak var itemId: UILabel!
    @IBOutlet weak var itemname: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var unitName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(from item: ItemInSqLite) {
        
        self.itemId.text = item.itemID
        self.itemname.text = item.itemName
        self.quantity.text = String(format: "%.2f", item.quantity ?? 0)
        self.price.text = "\(String(format: "%.2f", item.price)) €"
        self.unitName.text =  item.unitName
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
