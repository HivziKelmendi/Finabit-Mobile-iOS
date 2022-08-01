//
//  ClientCell.swift
//  Finabit Mobile
//
//  Created by Hivzi on 22.3.22.
//

import UIKit

class ClientCell: UITableViewCell {

    @IBOutlet weak var partnerName: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(from client: PartnerInSqLite) {
        
        self.partnerName.text = client.partnerName
        self.address.text = client.address
      
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
