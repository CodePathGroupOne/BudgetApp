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

    @IBAction func nameField(_ sender: Any) {
    }
    
    @IBAction func amountField(_ sender: Any) {
    }
    
    @IBAction func dateField(_ sender: Any) {
    }
    
    
    @IBAction func accountField(_ sender: Any) {
    }
    
    @IBAction func testBudgetMenu1(_ sender: Any) {
    }
    
    @IBAction func testBudgetMenu2(_ sender: Any) {
    }
    
    @IBAction func notesField(_ sender: Any) {
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
        newTransaction["payee"] = nameField(_:)
        
        // Add a relation between the Transaction and Budget
        newTransaction["budget"] = testBudgetMenu1(_:)
        
        // This will save both newTransaction and newBudget
        newTransaction.saveInBackground()
        
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
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
