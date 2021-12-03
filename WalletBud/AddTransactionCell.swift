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
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        // Create the budget
        /*
         let newBudget = PFObject(className:"Budget")
         newBudget["name"] = "Tuition"
         newBudget["amount"] = 200.00
        */
        // Create the transaction
        let newTransaction = PFObject(className:"Transaction")
        newTransaction["payee"] = nameField.text
        
        // Add a relation between the Transaction and Budget
        //newTransaction["budget"] = testBudgetMenu1(_:)
        
        // This will save both newTransaction and newBudget
        newTransaction.saveInBackground()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
