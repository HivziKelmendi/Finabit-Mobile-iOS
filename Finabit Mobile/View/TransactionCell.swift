//
//  TransactionCell.swift
//  Finabit Mobile
//
//  Created by Hivzi on 1.4.22.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var emertimi: UILabel!
    @IBOutlet weak var sasiaDheCmimi: UILabel!
    @IBOutlet weak var zbritjaDheCmimi: UILabel!
    @IBOutlet weak var vlera: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(from newtransactionDetails: TransactionDetails) {
      emertimi.text = newtransactionDetails.itemName
      sasiaDheCmimi.text = "\(newtransactionDetails.quantity ?? 0) x \(newtransactionDetails.price ?? 0)"
        guard let rabatDouble = newtransactionDetails.rabat else { return}
        let rabatString = String(format: "%.1f", rabatDouble as! CVarArg)
        guard let rabat2Double = newtransactionDetails.rabat2 else { return }
          let rabat2String = String(format: "%.1f", rabat2Double as CVarArg)
        guard let safeValue = newtransactionDetails.value else { return }
        zbritjaDheCmimi.text = "Zbr.1:\(rabatString)%, Zbr.2:\(rabat2String)%  cm. me zb.: \(newtransactionDetails.value ?? 0) "
        vlera.text = String(format: "%.1f", safeValue)
    }
    
    
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
