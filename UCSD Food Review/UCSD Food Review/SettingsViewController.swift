//
//  SettingsViewController.swift
//  Pods
//
//  Created by Brian on 3/30/22.
//

import UIKit
import Parse
import AlamofireImage

class SettingsViewController: UIViewController {

    @IBOutlet weak var pfpImage: UIImageView!
    @IBAction func openCameraRoll(_ sender: Any) {
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name:String = user["fullname"] as! String
        nameField.text = name
       
        //image
        let imageFile = user["profilePhoto"] as! PFFileObject
        let imageURL = imageFile.url!
        let url = URL(string: imageURL)!
        pfpImage.af.setImage(withURL: url)
        pfpImage.layer.cornerRadius = pfpImage.layer.bounds.width / 2
        pfpImage.clipsToBounds = true
        pfpImage.layer.borderColor = UIColor.darkGray.cgColor
        pfpImage.layer.borderWidth = 2.0
        
    

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSubmit(_ sender: Any) {
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
