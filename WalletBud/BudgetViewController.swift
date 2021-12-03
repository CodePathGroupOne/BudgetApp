//
//  BudgetViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/25/21.
//

import UIKit
import Parse

class BudgetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let barAppearance = UINavigationBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(named: "GreenBar")!
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    /*
    // Create a budget object for the month
    let budget = PFObject(className:"Budget")
   // populate budget object
    budget.saveInBackground { (succeeded, error)  in
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }

    // Update Budget
    let query = PFQuery(className:"Budget")
    query.getObjectInBackground(withId: "xWMyZEGZ") { (budget: PFObject?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    } else if let budget = budget {
       // Update budget info
        budget.saveInBackground()
    }
    }
    
    // Get my budget
    let query = PFQuery(className:"Budget")
    query.whereKey("User", equalTo: currentUser)
    query.whereKey("Month Year", equalTo: currentMonth)
    query.findObjectsInBackground { (budget: [PFObject]?, error: Error?) in
       if let error = error {
          print(error.localizedDescription)
       } else if let budget = budget {

      // TODO: View budget...
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
