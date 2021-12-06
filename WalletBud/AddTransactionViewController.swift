//
//  AddTransactionViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 12/3/21.
//

import UIKit
import DropDown
import Parse

class AddTransactionViewController: UIViewController {
    
  
    @IBOutlet weak var ddView: UIView!
    @IBOutlet weak var dwLabel: UILabel!
    
    @IBOutlet weak var vendorField: UITextField!
    
    @IBOutlet weak var transactionDateField: UIDatePicker!
    @IBOutlet weak var amountField: UITextField!
    
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Common_hashtags")
        query.findObjectsInBackground { (hashtags,error) in
            if hashtags != nil {
                print(hashtags!)
                self.hashtagobject = hashtags!
                for i in 0...self.hashtagobject.count-1{
                    self.categoriesArray[i] = self.hashtagobject[i]["Hashtag"] as! String
                }
                self.categoriesdropDown.dataSource = self.categoriesArray
                self.ddView.reloadInputViews()
            }
            
        }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        categoriesdropDown.anchorView = ddView
        categoriesdropDown.dataSource = categoriesArray
        categoriesdropDown.bottomOffset = CGPoint(x: 0, y:(categoriesdropDown.anchorView?.plainView.bounds.height)!)
        categoriesdropDown.topOffset = CGPoint(x: 0, y:-(categoriesdropDown.anchorView?.plainView.bounds.height)!)
        categoriesdropDown.direction = .bottom
        categoriesdropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            dwLabel.text = categoriesArray[index]
            hashtagselectedindex = index
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveTransaction(_ sender: Any) {
        let transaction = PFObject(className: "Transactions")
        transaction["Amount"] = Double(amountField.text!)
        transaction["Transaction_vendor"] = vendorField.text!
        transaction["Transaction_date"] = transactionDateField.date
        transaction["User"] = PFUser.current()!
        transaction["hashTag"] = self.hashtagobject[hashtagselectedindex]
        transaction.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
                print("Transaction has been saved")
            } else {
                // There was a problem, check error.description
                print (":Error Saving transaction")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func showCategory(_ sender: Any) {
        categoriesdropDown.show()
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
