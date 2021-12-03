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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emailField: UITextField!
    
    //user.username = usernameField.text
    //user.password = passwordField.text
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let barAppearance = UINavigationBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = UIColor(named: "GreenBar")!
        
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }

    @IBAction func onSignin(_ sender: Any) {
        self.indicator.startAnimating()
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                self.indicator.stopAnimating()
                print("Successful login into account: \(String(self.usernameField.text!))")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error with login: \(String(describing: error?.localizedDescription))")
                    /*if (String(describing: error:.localizedDescription)) == "Invalid username/password."
                    {
                        let alert = UIAlertController(title: "Your username or password is invalid.", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    else {
                    */
                self.displayAlert(withTitle: "There was an error signing in to your account.", message: error!.localizedDescription)
                self.indicator.stopAnimating()
                    //}
            }
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text!
        user.password = passwordField.text!
        
        self.indicator.startAnimating()
        user.signUpInBackground { (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                print("Error with sign up: \(String(describing: error.localizedDescription))")
                self.displayAlert(withTitle: "There was an error creating your account.", message: error.localizedDescription)
                self.indicator.stopAnimating()
            } else {
                print("Signed up for an account with username \(String(self.usernameField.text!))")
                //print("Signed up for an account with username \(String(username)) and email \(String(email))")
                self.indicator.stopAnimating()
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        //self.performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in NSLog("The user pressed \"OK\" in response to the alert.")}))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func onCompleteSignup(_ sender: Any) {
        let user = PFUser()
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
}
