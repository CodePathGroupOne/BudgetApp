//
//  OverviewViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/19/21.
//

import UIKit
import Parse

class OverviewViewController: UIViewController {

    @IBAction func sampleButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   /*
    // Read transactions
    let query = PFQuery(className:"Transactions")
    query.whereKey("User", equalTo: currentUser)
    query.order(byDescending: " Transaction_date ")
    query.findObjectsInBackground { (transactions: [PFObject]?, error: Error?) in
       if let error = error {
          print(error.localizedDescription)
       } else if let transactions = transactions {
      // TODO: Do something with transactions.
       }
    }

    
    // Read Budget
    let query = PFQuery(className:"Budget")
    query.whereKey("User", equalTo: currentUser)
    query.whereKey("Month Year", equalTo: currentMonth)
    query.findObjectsInBackground { (budget: [PFObject]?, error: Error?) in
       if let error = error {
          print(error.localizedDescription)
       } else if let budget = budget {

      // TODO: Do something with budget...
       }
    }
*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
