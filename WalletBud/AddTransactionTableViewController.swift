//
//  AddTransactionTableViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 12/3/21.
//

import UIKit
import Parse
import DropDown

class AddTransactionTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var amountField: UITextField!
    @IBOutlet var dateField: UIDatePicker!
    @IBOutlet weak var notesField: UITextView!
    
    @IBOutlet weak var categoryDropDownView: UIView!
    @IBOutlet weak var categoryButton: UIButton!
    
    var categoryLabel: String!
    
    var hashtagObject = [PFObject]()
    var categoriesDropDown = DropDown()
        
    var categoriesArray = [
      "Loading","Loading",
      "Loading","Loading",
      "Loading","Loading",
      "Loading","Loading",
      "Loading","Loading",
        ]
    
    var hashtagSelectedIndex = Int()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Common_hashtags")
        query.findObjectsInBackground { (hashtags,error) in
            if hashtags != nil {
                print(hashtags!)
                self.hashtagObject = hashtags!
                for i in 0...self.hashtagObject.count-1{
                    self.categoriesArray[i] = self.hashtagObject[i]["Hashtag"] as! String
                }
                self.categoriesDropDown.dataSource = self.categoriesArray
                self.categoryDropDownView.reloadInputViews()
            }
        }
    }
    
    @IBAction func showCategory(_ sender: Any) {
        categoriesDropDown.show()
    }
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let vendor = nameField.text ?? ""
        let amount = amountField.text ?? ""
        //let account = accountField.text ?? ""
        let date = dateField.date
        let category = categoryLabel
        let notes = notesField.text ?? ""
        
        print("Add button was tapped. Here is the information from the table view:")
        print("vendor name: \(vendor)")
        print("amount: \(amount)")
        //print("account: \(account)")
        print("date: \(date)")
        print("category: \(category)")
        print("notes: \(notes)")
        
        let transaction = PFObject(className: "Transactions")
        transaction["User"] = PFUser.current()!
        
        transaction["Transaction_vendor"] = vendor
        transaction["Amount"] = Double(amount)
        //transaction["Account"] =
        transaction["Transaction_date"] = date
        transaction["hashTag"] = self.hashtagObject[hashtagSelectedIndex]
        transaction["notes"] = notes
        transaction.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
                print("The transaction has been saved successfully.")
                self.dismiss(animated: true, completion: nil)
            } else {
                // There was a problem, check error.description
                print ("Error when saving the transaction.")
            }
        }
        self.dismiss(animated: true, completion: nil)
        
        //tableView.beginUpdates()
        //tableView.endUpdates()
    }
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesDropDown.anchorView = categoryDropDownView
        categoriesDropDown.dataSource = categoriesArray
        categoriesDropDown.bottomOffset = CGPoint(x: 0, y:(categoriesDropDown.anchorView?.plainView.bounds.height)!)
        categoriesDropDown.topOffset = CGPoint(x: 0, y:-(categoriesDropDown.anchorView?.plainView.bounds.height)!)
        categoriesDropDown.direction = .bottom
        categoriesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected category: \(item) at index: \(index)")
            categoryLabel = categoriesArray[index]
            categoryButton.setTitle(categoriesArray[index], for: .normal)
            hashtagSelectedIndex = index
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    let rowsAndSections = [["0,0", "0,1"], ["1,0"], ["2,0", "2,1"]]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowsAndSections[section].count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
