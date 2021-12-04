//
//  BudgetViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/25/21.
//

import UIKit
import Parse

class BudgetViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var hashtags = [PFObject]()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        let barAppearance = UINavigationBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(named: "GreenBar")!
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Common_hashtags")
        query.findObjectsInBackground { (hashtags,error) in
            if hashtags != nil {
                self.hashtags = hashtags!
                self.tableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hashtags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell") as! BudgetCell
        
        let common_hashtags = hashtags[indexPath.row]
        let hashtag  = common_hashtags["Hashtag"] as! String
        cell.HashTagLabel.text = hashtag
        
        return cell
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
