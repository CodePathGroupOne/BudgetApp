//
//  EditTransactionViewController.swift
//  WalletBud
//
//  Created by Sohil Shrestha on 12/5/21.
//

import UIKit
import Parse
import DropDown

class EditTransactionViewController: UIViewController {
    
    @IBOutlet weak var vendorField: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var Amount: UITextField!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var notesField: UITextView!
    
   
    @IBOutlet weak var categoryButton: UIButton!
    
    var categoryLabel: String!
    
    var hashtagobject = [PFObject]()
    let categoriesdropDown =  DropDown()
    
    var categoriesArray = [
        "Loading","Loading",
        "Loading","Loading",
        "Loading","Loading",
        "Loading","Loading",
        "Loading","Loading",
    ]
    var hashtagselectedindex = Int()
    
    var transaction : PFObject!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // This will call view willappear method from previous view controller
        presentingViewController?.viewWillAppear(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Common_hashtags")
        query.findObjectsInBackground { (hashtags,error) in
            if hashtags != nil {
                
                self.hashtagobject = hashtags!
                                for i in 0...self.hashtagobject.count-1{
                                    self.categoriesArray[i] = self.hashtagobject[i]["Hashtag"] as! String
                                    if(self.hashtagobject[i].objectId == (self.transaction["hashTag"] as! PFObject).objectId){
                                        self.hashtagselectedindex = i
                                        self.categoryButton.setTitle(self.hashtagobject[i]["Hashtag"] as! String, for: .normal)
                                        //self.dropdownLabel.text = self.hashtagobject[i]["Hashtag"] as! String
                                    }
                                }
                                self.categoriesdropDown.dataSource = self.categoriesArray
                
                self.categoryView.reloadInputViews()
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let transaction_amount = transaction["Amount"]!
        Amount.text = String(describing: transaction_amount)
        vendorField.text = transaction["Transaction_vendor"] as? String
        date.date = transaction["Transaction_date"] as! Date
        notesField.text = transaction["notes"] as? String
        
        
        categoriesdropDown.anchorView = categoryView
        categoriesdropDown.dataSource = categoriesArray
        categoriesdropDown.bottomOffset = CGPoint(x: 0, y:(categoriesdropDown.anchorView?.plainView.bounds.height)!)
        categoriesdropDown.topOffset = CGPoint(x: 0, y:-(categoriesdropDown.anchorView?.plainView.bounds.height)!)
        categoriesdropDown.direction = .bottom
        categoriesdropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            categoryButton.setTitle(categoriesArray[index], for: .normal)
            //dropdownLabel.text = categoriesArray[index]
            hashtagselectedindex = index
        }
         
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onDropDown(_ sender: Any) {
        categoriesdropDown.show()
    }
    
    @IBAction func updateTransaction(_ sender: Any) {
        let query = PFQuery(className:"Transactions")
        query.getObjectInBackground(withId: transaction.objectId!) { (updatetransaction: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let updatetransaction = updatetransaction {
                updatetransaction["Amount"] = Double(self.Amount.text!)
                updatetransaction["Transaction_vendor"] = self.vendorField.text!
                updatetransaction["Transaction_date"] = self.date.date
                updatetransaction["hashTag"] = self.hashtagobject[self.hashtagselectedindex]
                updatetransaction["notes"] = self.notesField.text!
                // Update budget info
                updatetransaction.saveInBackground()
                //Show some error to user
                self.dismiss(animated: true, completion: nil)
            
                
            }
        }
    }
    @IBAction func deleteTransaction(_ sender: Any) {
            let alert = UIAlertController(title: "Are you sure you want to delete this transaction?", message: "", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete Transaction", style: .destructive) { (action) in
                self.transaction.deleteInBackground()
                self.dismiss(animated: true, completion: nil)
                print(action)}
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let rowsAndSections = [["0,0", "0,1"], ["1,0"], ["2,0", "2,1"]]
    

        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
