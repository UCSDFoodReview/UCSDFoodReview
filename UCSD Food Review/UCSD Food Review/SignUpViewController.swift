//
//  SignUpViewController.swift
//  UCSD Food Review
//
//  Created by David Em-Yinn on 3/11/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    /*
     Outlets:
     fullNameField: user's full name
     signupEmailField: user's email
     signupPassField: user's password
     */
    
    @IBOutlet weak var fullNameField: UITextField!
    
    @IBOutlet weak var signupUsernameField: UITextField!
    
    @IBOutlet weak var signupPassField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
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
    
    
    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = signupUsernameField.text
        user.password = signupPassField.text
        user["fullname"] = fullNameField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        
        
    }
    
    
    
}
