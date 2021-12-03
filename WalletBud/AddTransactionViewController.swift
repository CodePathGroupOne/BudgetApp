//
//  AddTransactionViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 12/3/21.
//

import UIKit

class AddTransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! AddTransactionCell

        cell.nameField.delegate = self // theField is your IBOutlet UITextfield in your custom cell

        cell.nameField.text = "Test"

        return cell
    }
    
    var allCellsText = [String]()

    func textFieldDidEndEditing(_ textField: UITextField) {
        allCellsText.append(textField.text!)
        print(allCellsText)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
