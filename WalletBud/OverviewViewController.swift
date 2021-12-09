//
//  OverviewViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/19/21.
//

import UIKit
import Parse
import Charts
class OverviewViewController: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    var pieChart = PieChartView()
    var barChart = BarChartView()
    var budget_by_hashtag = [String:Decimal]()
    var transaction_by_hashtag = [String:Decimal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentMonthMetric(metric: "Budget")
        
        getCurrentMonthMetric(metric: "Transactions")
        
        //createPieChart()
        
        //createBarChart()
        
        // Do any additional setup after loading the view.
        /*let barAppearance = UINavigationBarAppearance()
         
         barAppearance.configureWithOpaqueBackground()
         barAppearance.backgroundColor = UIColor(named: "GreenBar")!
         
         navigationController?.navigationBar.standardAppearance = barAppearance
         navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
         */
    }
    
    func getCurrentMonthMetric( metric: String) {
        
        
        // Get current budget
        let currentUser:PFUser = PFUser.current()!
        let month_year = getCurrentandNextMonthAndYear()
        let month_year_str = month_year[0] + " " + month_year[1]
        let current_month = stringToDate(month_year_str)
        
        let next_month_year_str = month_year[2] + " " + month_year[3]
        let next_month = stringToDate(next_month_year_str)
        let query = PFQuery(className:metric)
        
        
        query.whereKey("User", equalTo: currentUser)
        if metric == "Budget"{
            query.includeKey("Hashtag")
            query.whereKey("Year_Month", equalTo: current_month)
            
        }else if metric == "Transactions"{
            query.includeKey("hashTag")
            query.whereKey("Transaction_date", greaterThanOrEqualTo: current_month)
            query.whereKey("Transaction_date", lessThan: next_month)
        }
        query.findObjectsInBackground{
            (result,error) in
            if error == nil {
                let results = result!
                
                for i in 0..<results.count{
                    if metric == "Budget"{
                        var temp = (results[i]["Hashtag"] as! PFObject)["Hashtag"] as! String
                        
                        self.budget_by_hashtag[temp] = Decimal(results[i]["Budget_Amount"] as! Double)
                    }else if metric == "Transactions"{
                        var temp = (results[i]["hashTag"] as! PFObject)["Hashtag"] as! String
                        if self.transaction_by_hashtag[temp] == nil{
                            self.transaction_by_hashtag[temp] = Decimal(results[i]["Amount"] as! Double)
                        }else{
                            self.transaction_by_hashtag[temp]! += Decimal(results[i]["Amount"] as! Double)
                        }
                        //self.pieChart.notifyDataSetChanged()
                        //self.barChart.notifyDataSetChanged()
                        
                    }
                    
                }
                
                //print(self.budget_by_hashtag)
                //print(self.transaction_by_hashtag)
            }
            else{
                print("There is an issue retrieveing recent transactions. ")
            }
            
        }
        
        
        
    }
    
    private func createPieChart()
    {
        // Create Pie Chart
        pieChart.frame = CGRect(x:0,y:0,width:
                                    self.topView.frame.size.width,
                                height: self.topView.frame.size.height)
        pieChart.center = self.topView.center
        pieChart.legend.enabled = false
        //pieChart.radius  =
        pieChart.drawEntryLabelsEnabled = false
        
        view.addSubview(pieChart)
        //Populate data
        var totalBudget = 0.00
        var totalTransaction = 0.00
        var entries = [ChartDataEntry]()
        for (key, value) in self.budget_by_hashtag{
            totalBudget += Double(truncating: value as NSNumber)
        }
        
        for (key, value) in self.transaction_by_hashtag{
            
            totalTransaction += Double(truncating: value as NSNumber)
        }
        let totalRemaining = totalBudget - totalTransaction
        let expense_percent = totalTransaction/totalBudget * 100
        pieChart.centerText = String( format: "%.2f",expense_percent) + "%" + "\nSpent"
        //entries for pie chart
        entries.append(ChartDataEntry(x:Double(1),y:totalTransaction))
        entries.append(ChartDataEntry(x:Double(2),y:totalRemaining))
        
        
        
        let set = PieChartDataSet(entries: entries)
        var  colors: [UIColor] = []
        colors.append(UIColor.blue)
        colors.append(UIColor.gray)
        
        
        
        set.colors = colors
        //set.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
    
    private func createBarChart(){// Bar Chart
        barChart.frame = CGRect(x:0,y:0,width:
                                    self.bottomView.frame.size.width,
                                height: self.bottomView.frame.size.height)
        barChart.center = self.bottomView.center
        //barChart.legend.enabled = false
        //view.addSubview(barChart)
        let legend = barChart.legend
        
        //Confuigure the axis
        //let xAxis = barChart.xAxis
        
        var barentries = [BarChartDataEntry]()
        
        for x in 1..<10{
            barentries.append(BarChartDataEntry(x:Double(x),y:Double.random(in: 0...30)))
        }
        
        let barset = BarChartDataSet(entries: barentries,label: "Cost")
        barset.colors = ChartColorTemplates.pastel()
        let bardata = BarChartData(dataSet: barset)
        barChart.data = bardata
        view.addSubview(barChart)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createPieChart()
        self.createBarChart()
    }
    
    func getCurrentandNextMonthAndYear() -> Array<String>{
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: now)
        
        var dateComponent = DateComponents()
        dateComponent.month = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: now)
        
        dateFormatter.dateFormat = "LLLL"
        let nextMonthName = dateFormatter.string(from: futureDate!)
        dateFormatter.dateFormat = "yyyy"
        let nextMonthYearString = dateFormatter.string(from: futureDate!)
        
        return [nameOfMonth,yearString,nextMonthName,nextMonthYearString]
    }
    func stringToDate(_ date: String) -> Date? {
        let df = DateFormatter()
        df.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        df.dateFormat = "LLLL yyyy"
        df.date(from: date)
        
        return df.date(from: date)
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
