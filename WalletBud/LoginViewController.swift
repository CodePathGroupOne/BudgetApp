//
//  LoginViewController.swift
//  WalletBud
//
//  Created by Ryan Johnson on 11/12/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    let user = PFUser()
    //user.username = usernameField.text
    //user.password = passwordField.text
    
    @IBAction func onLogin(_ sender: Any) {

        let username = usernameField.text!
        let password = passwordField.text!
            
        PFUser.logInWithUsername(inBackground: username, password: password)
            { (user, error) in
                if user != nil {
                    print("Signed into account: \(String(username))")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    print("Error with sign in: \(String(describing: error?.localizedDescription))")
                }
            }
    }

    @IBAction func onSignup(_ sender: Any) {
        
        let username = usernameField.text!
        
        user.signUpInBackground { (success, error) in
            if success {
                print("Signed up for an account with username \(String(username))")
                //print("Signed up for an account with username \(String(username)) and email \(String(email))")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
        //self.performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    @IBAction func onCompleteSignup(_ sender: Any) {
//        let email = emailField.text!
        
//        user.email = emailField.text

        user.signUpInBackground { (success, error) in
            if success {
                print("Signed up!")
                //print("Signed up for an account with username \(String(username)) and email \(String(email))")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
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
