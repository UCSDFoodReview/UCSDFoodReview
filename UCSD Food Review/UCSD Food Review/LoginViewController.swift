//
//  LoginViewController.swift
//  UCSD Food Review
//
//  Created by David Em-Yinn on 3/11/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    /*
     Outlets:
     loginEmailField: existing user's email
     loginPassField: existing user's password
     */
    
    @IBOutlet weak var loginUsernameField: UITextField!
    
    @IBOutlet weak var loginPassField: UITextField!
    
    
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

    
    @IBAction func onLogin(_ sender: Any) {
        let username = loginUsernameField.text!
        let password = loginPassField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        
    }
    
    
}
