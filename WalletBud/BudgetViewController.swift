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
    var hashtags_budget = [Decimal]()
    var budget_id = [String]()
    //Getting current month
    var month_year = [String]()
    var current_month = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        month_year = getCurrentMonthAndYear()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let bartitle = "Budget - " + month_year[0]
        
        let year_month = month_year[0] + " " + month_year[1]
        current_month = stringToDate(year_month)!
        //print(current_month)
        
        
        self.navigationItem.title = bartitle
        let barAppearance = UINavigationBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(named: "GreenBar")!
        
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    func getCurrentMonthAndYear() -> Array<String>{
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: now)
        
        return [nameOfMonth,yearString]
    }
    
    func stringToDate(_ date: String) -> Date? {
        let df = DateFormatter()
        df.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        df.dateFormat = "LLLL yyyy"
        df.date(from: date)
        
        return df.date(from: date)
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
    
    @objc func textFieldDidChange(_ sender: UITextField!) {
        let tableRow = sender.tag
        let formatter = NumberFormatter()
        
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = NumberFormatter.Style.decimal
        
        if let formattedNumber = formatter.number(from: sender.text!) as? NSDecimalNumber  {
            hashtags_budget[tableRow] = formattedNumber as Decimal
        }else {
            hashtags_budget[tableRow] = Decimal(0.00)
        }
        
    }
    
    @IBAction func onBudgetUpdate(_ sender: Any) {
        
        var message = ""
        //print("This button is working")
        let currentUser:PFUser = PFUser.current()!
        let query = PFQuery(className:"Budget")
        
        query.whereKey("User", equalTo: currentUser)
        query.whereKey("Year_Month", equalTo: current_month)
        query.limit = 1
     
        
        do {
            let budget = try query.findObjects()
            if (budget.count > 0){
                for i in 0...self.hashtags.count-1{
                    updateBudget(id: self.budget_id[i], budget_amount: self.hashtags_budget[i])
                }
                message = "Budget Updated"
                
            }else{
                for i in 0...self.hashtags.count-1{
                    createBudget(currentUser: currentUser, hashtag: self.hashtags[i], hashtag_budget: self.hashtags_budget[i])
                }
                message = "Budget Created"
                
            }
            let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
            
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        catch {
            print(error)
            
        }
        
        
        
       
    }
    
    func updateBudget(id:String, budget_amount: Decimal){
        // Update Budget
        let query = PFQuery(className:"Budget")
        query.getObjectInBackground(withId: id) { (budget: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let budget = budget {
                // Update budget info
                budget["Budget_Amount"] = budget_amount
                budget.saveInBackground()
            }
        }
    }
    
    func createBudget(currentUser: PFUser, hashtag: PFObject, hashtag_budget: Decimal) {
        // Create a budget object for the month
        let budget = PFObject(className:"Budget")
        // populate budget object
        /*print(currentUser)
         print(hashtag)
         print(hashtag_budget)
         */
        budget["User"] = currentUser
        budget["Hashtag"] = hashtag
        budget["Budget_Amount"] = hashtag_budget
        
        budget["Year_Month"] = current_month
        
        budget.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
                print("Object has been saved")
            } else {
                // There was a problem, check error.description
                print (":Error Saving budget")
            }
        }
        
    }
    func getCurrentMonthBudgetByHashTag(hashtag: PFObject, tableRow: Int) -> Decimal{
        
        var res = Decimal(-1)
        
        // Get current budget
        let currentUser:PFUser = PFUser.current()!
        let query = PFQuery(className:"Budget")
        query.includeKey("Hashtag")
        query.whereKey("User", equalTo: currentUser)
        query.whereKey("Year_Month", equalTo: current_month)
        let ht = PFObject(withoutDataWithClassName: "Common_hashtags", objectId: hashtag.objectId)
        //print(hashtag)
        query.whereKey("Hashtag",equalTo: ht)
        
        do {
            let budget = try query.findObjects()
            if (budget.count > 0){
                let val = budget[0]["Budget_Amount"] as! Double
                self.budget_id[tableRow] = budget[0].objectId as! String
                self.hashtags_budget[tableRow] = Decimal(val)
                res = Decimal(val)
                
            }
            
        }
        catch {
            print(error)
            
        }
        
        
        
        return res
        
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        print("Click")
        PFUser.logOut()
               let main = UIStoryboard(name: "Main", bundle: nil)
               let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
               guard  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return}
               
               delegate.window?.rootViewController = loginViewController
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for _ in 0...hashtags.count{
            hashtags_budget.append(Decimal(0.00))
            budget_id.append("a")
        }
        return hashtags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell") as! BudgetCell
        
        let common_hashtags = hashtags[indexPath.row]
        //print(common_hashtags)
        let budgetAmount = getCurrentMonthBudgetByHashTag(hashtag: common_hashtags, tableRow: indexPath.row)
        
        let hashtag  = common_hashtags["Hashtag"] as? String
        cell.categoryButton.setTitle(hashtag, for: .normal)
        
        if (budgetAmount > Decimal(-1)) {
            //print("I am here")
            cell.budgettextField.text = String(describing: budgetAmount)
        }
        
        cell.budgettextField.tag = indexPath.row
        cell.budgettextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        return cell
    }
    
    
    
    
    /*
     
     
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
