//
//  TransactionCell.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/30/21.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var vendorLabel: UILabel!
    // These are for the Transactions screen
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var expenseAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
