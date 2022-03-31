//
//  SettingsViewController.swift
//  Pods
//
//  Created by Brian on 3/30/22.
//

import UIKit
import Parse
import AlamofireImage

class SettingsViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pfpImage: UIImageView!
    
    
    
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
    
    @IBAction func openCameraRoll(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        pfpImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func onSubmit(_ sender: Any) {
        let imageData = pfpImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        user["profilePhoto"] = file
        
        user["fullname"] = nameField.text!
        if passwordField != nil {
            user["password"] = passwordField.text!
        }
        do {
            try user.save()
        }
        catch {
            print("Error")
        }
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
