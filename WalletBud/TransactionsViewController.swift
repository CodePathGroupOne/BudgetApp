//
//  TransactionsViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/25/21.
//

import UIKit
import Parse

class TransactionsViewController: UIViewController, UITableViewDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
    
    
    /*
    // Query transactions of the user
    let query = PFQuery(className: "Transactions")
    query.whereKey("User", equalTo: currentUser)
    query.order(byDescending: "Transaction_date ")
    query.findObjectsInBackground { (transactions: [PFObject]?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
        } else if let transactions == transactions {
            // TODO: Do something with transactions...
        }
    }

    // Update transactions
    let query = PFQuery(className:"Transactions")
    query.getObjectInBackground(withId: "xWMyZEGZ") { (transactions: PFObject?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
        } else if let transactions = transactions {
            // Update transactions info
            transactions.saveInBackground()
        }

    // Delete existing transactions
    PFObject.deleteAll(inBackground: objectArray) { (succeeded, error) in
        if (succeeded) {
            // The array of objects was successfully deleted.
        } else {
            // There was an error. Check the errors localizedDescription.
        }
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
*/
}
