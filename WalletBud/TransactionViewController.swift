//
//  TransactionViewController.swift
//  WalletBud
//
//  Created by Sohil Shrestha on 12/5/21.
//

import UIKit
import Parse

class TransactionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var transactions = [PFObject]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser:PFUser = PFUser.current()!
        let query = PFQuery(className:"Transactions")
        query.includeKey("hashTag")
        query.whereKey("User", equalTo: currentUser)
        query.addDescendingOrder("Transaction_date")
        query.limit = 4
        query.findObjectsInBackground{
            (result,error) in
            if error == nil {
                self.transactions = result!
                self.tableView.reloadData()
            }
            else{
                print("There is an issue retrieveing recent transactions. ")
            }
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell

        let transaction = transactions[indexPath.row]
        let hashtag = (transaction["hashTag"] as! PFObject)["Hashtag"]!
        
        let trans_date =  transaction["Transaction_date"] as! Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: trans_date )
       
        dateFormatter.dateFormat = "dd"
        let dateString = dateFormatter.string(from: trans_date )
     
    
        cell.vendorLabel.text = transaction["Transaction_vendor"] as! String
        cell.dateLabel.text = nameOfMonth + " " + dateString//transaction[]
       
        cell.expenseAmount.text = String(format: "%.2f", (transaction["Amount"] as! Double))
        cell.hashtagLabel.text = hashtag as! String
        
        return cell
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
