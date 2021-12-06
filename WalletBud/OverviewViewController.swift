//
//  OverviewViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/19/21.
//

import UIKit
import Parse

class OverviewViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*let barAppearance = UINavigationBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(named: "GreenBar")!
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
         */
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        print("Click")
        PFUser.logOut()
               let main = UIStoryboard(name: "Main", bundle: nil)
               let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
               guard  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return}
               
               delegate.window?.rootViewController = loginViewController
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
