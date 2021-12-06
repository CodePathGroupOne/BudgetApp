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
    @IBOutlet var accountField: UITextField!
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryMenu: UIMenu!
    
    var hashtagObject = [PFObject]()
    var categoriesArray = [
      "Loading","Loading",
      "Loading","Loading",
      "Loading","Loading",
      "Loading","Loading",
      "Loading","Loading",
        ]
    
    var hashtagSelectedIndex = Int()
    var category = String()
    
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
                // Pass the categories to the picker
                //self.categoryPicker.dataSource = self.categoriesArray
                //self.ddView.reloadInputViews()
            }
        }
    }
    
    // var dateFormatter: DateFormatter = {
    //  let dateFormatter = DateFormatter()
    //  dateFormatter.dataStyle = .medium
    //
    //  return dateFormatter
    //}()
    
    //categoryLabel.text = \(String(describing: pickerView(categoryPicker, titleForRow: 0, forComponent: 0)))
    
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let vendor = nameField.text ?? ""
        let amount = amountField.text ?? ""
        let account = accountField.text ?? ""
        let date = dateField.date
        //category = pickerView(categoryPicker, titleForRow: 0, forComponent: 0)
        //let notes = notesField.text ?? ""
        
        print("Add button was tapped. Here is the information from the table view:")
        print("vendor name: \(vendor)")
        print("amount: \(amount)")
        print("account: \(account)")
        print("date: \(date)")
        print("category: \(String(describing: category))")
        
        let transaction = PFObject(className: "Transactions")
        transaction["User"] = PFUser.current()!
        
        transaction["Transaction_vendor"] = vendor
        transaction["Amount"] = Double(amount)
        //transaction["Account"] =
        transaction["Transaction_date"] = date
        //transaction["hashTag"] = self.hashtagObject[hashtagSelectedIndex]
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
    }
    
    /*
    // This stuff is for the category picker
    
    // Hide the picker unless active
    let categoryPickerCellIndexPath = IndexPath(row: 2, section: 3)
    let categoryLabelCellIndexPath = IndexPath(row: 1, section: 3)
    var isCategoryPickerVisible: Bool = false {
        didSet {
            categoryPicker.isHidden = !isCategoryPickerVisible
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case categoryPickerCellIndexPath where isCategoryPickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath == categoryLabelCellIndexPath && isCategoryPickerVisible == false {
            // category label selected, toggle check-in picker
            isCategoryPickerVisible.toggle()
        }// else {
            // either label was selected, previous conditions failed meaning at least one picker is visible, toggle both
           // isCategoryPickerVisible.toggle()
        //} else {
        //    return
        //}

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesArray.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesArray[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        hashtagSelectedIndex = row
        category = categoriesArray[row] as String
        
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        /*
        categoriesDropDown.anchorView = AddTransactionTableViewController
        categoriesDropDown.dataSource = categoriesArray
        categoriesDropDown.bottomOffset = CGPoint(x: 0, y:(categoriesDropDown.anchorView?.plainView.bounds.height)!)
        categoriesDropDown.topOffset = CGPoint(x: 0, y:-(categoriesDropDown.anchorView?.plainView.bounds.height)!)
        categoriesDropDown.direction = .bottom
        categoriesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            dwLabel.text = categoriesArray[index]
            hashtagSelectedIndex = index
        }
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
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
