//
//  OverviewViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/19/21.
//

import UIKit
import Parse
import Charts

class OverviewViewController: UIViewController,ChartViewDelegate {
    
    var pieChart = PieChartView()
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect(x:0,y:0,width:
                                self.bottomView.frame.size.width,
                                height: self.bottomView.frame.size.width)
        pieChart.center = self.bottomView.center
        
        pieChart.centerText = "This is the text\n 70%added"
        view.addSubview(pieChart)
 
        var entries = [ChartDataEntry]()
        
        for x in 1..<3{
            entries.append(ChartDataEntry(x:Double(x),y:Double(x)))
        }
                           
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
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
        /*
        // Get current budget
        let currentUser:PFUser = PFUser.current()!
        let query = PFQuery(className:"Budget")
        let month_year = getCurrentMonthAndYear()
        let year_month = month_year[0] + " " + month_year[1]
        query.whereKey("User", equalTo: currentUser)
        query.whereKey("Year_Month", equalTo: current_month)
        
        query.findObjectsInBackground { (hashtags,error) in
            if hashtags != nil {
                
                self.hashtagobject = hashtags!
                for i in 0...self.hashtagobject.count-1{
                    self.categoriesArray[i] = self.hashtagobject[i]["Hashtag"] as! String
                    if(self.hashtagobject[i].objectId == (self.transaction["hashTag"] as! PFObject).objectId){
                        self.hashtagselectedindex = i
                        self.dropdownLabel.text = self.hashtagobject[i]["Hashtag"] as! String
                    }
                }
                self.categoriesdropDown.dataSource = self.categoriesArray
                
                self.categoryView.reloadInputViews()
            }
            
        }*/
    }
    @IBAction func onSignOut(_ sender: Any) {
        
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
