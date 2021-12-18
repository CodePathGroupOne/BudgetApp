//
//  OverviewViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/19/21.
//

import UIKit
import Parse
import Charts

class OverviewViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    
    //Create Charts
    var pieChart = PieChartView()
    var barChart = BarChartView()
    
    var budget_by_hashtag = [String:Decimal]()
    var transaction_by_hashtag = [String:Decimal]()
    var hashtags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded")
        //Configure properties such as Legends and Axis
        self.setUpBarChartProperties()
        self.setUpPieChartProperties()
       // self.barChart.delegate = self
        //self.pieChart.delegate = self
        
   
         
    }
    
    private func setUpPieChartProperties(){
        self.pieChart.frame = CGRect(x:0,y:0,width:
                                    self.topView.frame.size.width,
                                height: self.topView.frame.size.height)
        self.pieChart.center = self.topView.center
        self.pieChart.legend.enabled = true
        //pieChart.radius  =
        self.pieChart.drawEntryLabelsEnabled = false
    }
    private func setUpBarChartProperties(){
        //Legend
        let legend = self.barChart.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 2.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        //Axis
        let formatter = NumberFormatter()
        formatter.negativePrefix = " $"
        formatter.positivePrefix = " $"
        
        let yaxis = self.barChart.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        
        //Others
        self.barChart.frame = CGRect(x:0,y:0,width:
                                    self.bottomView.frame.size.width,
                                height: self.bottomView.frame.size.height)
        self.barChart.center = self.bottomView.center

        //view.addSubview(barChart)
        self.barChart.noDataText = "Fetching data. Go to other tab"
        

        
        //barChart.xAxis.granularityEnabled = true
        self.barChart.xAxis.granularity = 1
        self.barChart.xAxis.centerAxisLabelsEnabled = true
        // barChart.xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
      
        self.barChart.xAxis.labelPosition = .bottom
        self.barChart.xAxis.labelRotationAngle = 280
        self.barChart.xAxis.drawGridLinesEnabled = true
        self.barChart.xAxis.labelCount = 10
        self.barChart.xAxis.granularityEnabled = true
        self.barChart.rightAxis.enabled = false
        
    }
    
    func getCurrentMonthMetric( metric: String) {
        //Emptying Transaction by hashtag
        
        
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
            query.addAscendingOrder("Hashtag.createdAt")
            query.whereKey("Year_Month", equalTo: current_month)
            
        }else if metric == "Transactions"{
            query.includeKey("hashTag")
            query.addAscendingOrder("hashTag.createdAt")
            query.whereKey("Transaction_date", greaterThanOrEqualTo: current_month)
            query.whereKey("Transaction_date", lessThan: next_month)
        }
        query.findObjectsInBackground { (result,error) in
            //print(result)
            if result != nil {
                let results = result!
               
                for i in 0..<results.count {
                    if metric == "Budget" {
                        var temp = (results[i]["Hashtag"] as! PFObject)["Hashtag"] as! String
                        
                        self.budget_by_hashtag[temp] = Decimal(results[i]["Budget_Amount"] as! Double)
                    } else if metric == "Transactions" {
                        var temp = (results[i]["hashTag"] as! PFObject)["Hashtag"] as! String
                        if self.transaction_by_hashtag[temp] == nil {
                            self.transaction_by_hashtag[temp] = Decimal(results[i]["Amount"] as! Double)
                        } else {
                            self.transaction_by_hashtag[temp]! += Decimal(results[i]["Amount"] as! Double)
                        }
                    }
                }
                //print(self.budget_by_hashtag)
                //print(self.transaction_by_hashtag)
                //Bar Chart DAta update
                self.updateBarChartData()
                self.barChart.data?.notifyDataChanged()
                self.barChart.notifyDataSetChanged()
                
                //PieChart Data update
                self.updatePieChartData()
                self.pieChart.data?.notifyDataChanged()
                self.pieChart.notifyDataSetChanged()
            }
            else {
                print("There is an issue retrieveing recent transactions. ")
            }
            print(self.transaction_by_hashtag)
            
        }
    }
    
    private func updatePieChartData()
    {
       
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
        var totalRemaining = totalBudget - totalTransaction
        if totalRemaining < 0 {
            totalRemaining = 0
        }
        let expense_percent = totalTransaction/totalBudget * 100
        self.pieChart.centerText = String(format: "%.2f",expense_percent) + "%" + "\nSpent"
        //entries for pie chart
        entries.append(ChartDataEntry(x:Double(1),y:totalTransaction))
        entries.append(ChartDataEntry(x:Double(2),y:totalRemaining))
        
        
        
        let set = PieChartDataSet(entries: entries, label: "Total Budget")
        let legendsPoint = ["Spent","Remaining"]
    
        
        var colors: [UIColor] = []
        colors.append(UIColor(red: 0.36, green: 0.69, blue: 0.46, alpha: 1.00)) // use the GreenBar color
        colors.append(UIColor.gray)
        
        set.colors = colors
     
        let data = PieChartData( dataSet: set)
        
   
        self.pieChart.data = data
        view.addSubview(self.pieChart)
     
    }
    
    private func updateBarChartData() {// Bar Chart
        var bar_entries_budget = [BarChartDataEntry]()
        var bar_entries_transaction = [BarChartDataEntry]()
        var x = 0
        self.hashtags = ["DUMMY"] // because formatter start at index 1. 
        for (key, value) in self.budget_by_hashtag{
            self.hashtags.append(key)
            bar_entries_budget.append(BarChartDataEntry(x:Double(x),y:Double(truncating: value as NSNumber), data:key))
            if self.transaction_by_hashtag[key] != nil{
            
                bar_entries_transaction.append(BarChartDataEntry(x:Double(x),y:Double(truncating: self.transaction_by_hashtag[key] as! NSNumber)))
            }else{
                bar_entries_transaction.append(BarChartDataEntry(x:Double(x),y:Double(0)))
            }
            
            x+=1
            
        }
     
        if self.budget_by_hashtag.count != 0{
            //print(self.hashtags)
            //print(bar_entries_budget)
            //print(bar_entries_transaction)
            barChart.xAxis.valueFormatter =  IndexAxisValueFormatter(values: self.hashtags)
            barChart.notifyDataSetChanged()
        }
        let bar_budget_set = BarChartDataSet(entries: bar_entries_budget,label: "Budget")
        let bar_transaction_set = BarChartDataSet(entries: bar_entries_transaction,label: "Expense")
        let dataSets: [BarChartDataSet] = [bar_budget_set,bar_transaction_set]
        bar_budget_set.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //bar_budget_set.colors = ChartColorTemplates.pastel()
        
        let bar_data = BarChartData(dataSets: dataSets)
       
        
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        
        bar_data.barWidth = barWidth
        barChart.xAxis.axisMinimum = Double(1.0)
        let gg = bar_data.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChart.xAxis.axisMaximum = Double(1.0) + gg * Double(10)
        
        
        
        bar_data.groupBars(fromX: Double(1.0), groupSpace: groupSpace, barSpace: barSpace)
        //Doesnot display value above or below the bars
        bar_data.setDrawValues(false)
        
        barChart.data = bar_data
        
        barChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        view.addSubview(barChart)
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        getCurrentMonthMetric(metric: "Budget")
        getCurrentMonthMetric(metric: "Transactions")
        //self.createPieChart()
        
        //self.pieChart.data?.notifyDataChanged()
        //self.pieChart.notifyDataSetChanged()
        
        
        
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.transaction_by_hashtag.removeAll()
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
