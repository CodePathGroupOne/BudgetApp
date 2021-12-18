//
//  TransactionViewController.swift
//  WalletBud
//
//  Created by Sohil Shrestha on 12/5/21.
//

import UIKit
import Parse

class TransactionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    var transactions = [PFObject]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //This function will be called when returning from edit/add transaction view controller
        // The viewWillDisapper method needs to be overridden in those view controllers.
              super.viewWillAppear(animated)
              //refresh
        let currentUser:PFUser = PFUser.current()!
        let query = PFQuery(className:"Transactions")
        query.includeKey("hashTag")
        query.whereKey("User", equalTo: currentUser)
        query.addDescendingOrder("Transaction_date")
        query.limit = 10
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
        clearOnAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser:PFUser = PFUser.current()!
        let query = PFQuery(className:"Transactions")
        query.includeKey("hashTag")
        query.whereKey("User", equalTo: currentUser)
        query.addDescendingOrder("Transaction_date")
        query.limit = 10
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
        clearOnAppearance()
    }
    
    func clearOnAppearance() {
        for indexPath in tableView.indexPathsForSelectedRows ?? [] {
            tableView.deselectRow(at: indexPath, animated: true)
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
        
        
        cell.vendorLabel.text = transaction["Transaction_vendor"] as? String
        cell.dateLabel.text = nameOfMonth + " " + dateString//transaction[]
        
        cell.expenseAmount.text = String(format: "%.2f", (transaction["Amount"] as! Double))
        cell.categoryButton.setTitle(hashtag as? String, for: .normal)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        
        let barAppearance = UINavigationBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(named: "GreenBar")!
        
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        
        clearOnAppearance()
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let isBarButton = ( sender is UIBarButtonItem ? false : true)
            if (isBarButton) {
                // Get the new view controller using segue.destination.
                let cell = sender as! UITableViewCell
                let indexPath = tableView.indexPath(for: cell)!
                let transaction = transactions[indexPath.row]
           
                // Pass the selected object to the new view controller.
                let editTransactionViewController = segue.destination as! EditTransactionViewController
                editTransactionViewController.transaction = transaction
            }
        }
    
    
}
