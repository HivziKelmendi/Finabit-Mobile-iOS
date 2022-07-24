//
//  PurchaeseCell.swift
//  Finabit Mobile
//
//  Created by Hivzi on 12.7.22.
//

import UIKit

class PurchaeseCell: UITableViewCell {

    @IBOutlet weak var konsumatori: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var shuma: UILabel!
    @IBOutlet weak var isSynchronizedImage: UIImageView!
    let image1 = UIImage(systemName: "checkmark.square.fill")
    let image2 = UIImage(systemName: "clear.fill")
    
    var partnerName: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateTransactionInVisits(from newTransaction: TransactionInSqLite) {
        konsumatori.text = newTransaction.partnerName
        shuma.text = String(format: "%.1f", newTransaction.allValue)
        let date = newTransaction.transactionDate
        if newTransaction.iSynchronized == 1 {
            isSynchronizedImage.image = image1
            isSynchronizedImage.tintColor = .systemGreen
        }
        else {
            isSynchronizedImage.image = image2
            isSynchronizedImage.tintColor = .systemRed
        }
        let newdate = dateFromWebtoApp(date!)
        data.text = newdate
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func dateFromWebtoApp(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date ?? Date.now)
    }
}
