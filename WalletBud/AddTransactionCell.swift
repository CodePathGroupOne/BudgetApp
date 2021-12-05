//
//  AddTransactionCell.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/30/21.
//

import UIKit
import Parse

class AddTransactionCell: UITableViewCell {
    
    // These are for the Add Transactions screen
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var testBudgetMenu1: UIMenu!
    @IBOutlet weak var testBudgetMenu2: UIMenu!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
