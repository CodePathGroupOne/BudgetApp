//
//  SettingsViewController.swift
//  WalletBud
//
//  Created by Sohil Shrestha on 12/3/21.
//

import UIKit
import Parse

class SettingsTableViewController: UITableViewController {

    @IBOutlet var settingsTableView: UITableView!
    
    @IBOutlet weak var usernameField: UILabel!
    @IBAction func onSignOut(_ sender: Any) {
     
        PFUser.logOut()
               let main = UIStoryboard(name: "Main", bundle: nil)
               let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
               guard  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return}
               
               delegate.window?.rootViewController = loginViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.text = PFUser.current()?.username
        // Do any additional setup after loading the view.
        self.tableView.contentInset.bottom = 100
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
