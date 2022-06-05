//
//  OrderCell.swift
//  Finabit Mobile
//
//  Created by Hivzi on 4.6.22.
//

import UIKit

class OrderCell: UITableViewCell {
   
    @IBOutlet weak var konsumatori: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var shuma: UILabel!
    
    var partnerName: String = ""
    var partnerId: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func fetchPartner() {
        if let safePartnerId = partnerId {
        PersistenceManager.shared.fetchingPartnerById(partnerData: safePartnerId) {[weak self] result in
            switch result {
            case .success(let partner):
                self?.partnerName = partner[0].partnerName ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        }
    }

    func updateTransactionInVisits(from newTransaction: TransactionInSqLite) {
        konsumatori.text = String(newTransaction.partnerId)
        let date = newTransaction.transactionDate
        
        let newdate = dateFromWebtoApp(date!)
        
        data.text = newdate
        konsumatori.text = partnerName
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
