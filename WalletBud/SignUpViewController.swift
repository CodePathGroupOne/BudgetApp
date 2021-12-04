//
//  SignUpViewController.swift
//  WalletBud
//
//  Created by Sohil Shrestha on 12/3/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {


    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var dobField: UIDatePicker!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text!
        user.password = passwordField.text!
        user.email = emailField.text!
        user["dob"] = dobField.date
        user["firstName"] = firstnameField.text!
        user["lastName"] = lastNameField.text!
        
        
       user.signUpInBackground { (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                print("Error with sign up: \(String(describing: error.localizedDescription))")
                self.displayAlert(withTitle: "There was an error creating your account.", message: error.localizedDescription)
                //self.indicator.stopAnimating()
            } else {
                print("Signed up for an account with username \(String(self.usernameField.text!))")
                //print("Signed up for an account with username \(String(username)) and email \(String(email))")
                //self.indicator.stopAnimating()
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
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
      
      var returnValue = true
      let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
      
      do {
          let regex = try NSRegularExpression(pattern: emailRegEx)
          let nsString = emailAddressString as NSString
          let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0
          {
              returnValue = false
          }
          
      } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
      }
      
      return  returnValue
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
