//
//  TransactionCell.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/30/21.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    // These are for the Transactions screen
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var budgetLabelButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
