//
//  ReviewViewController.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit
import Cosmos
import Parse
import CryptoKit

class ReviewViewController: UIViewController {
    
    weak var delegate:ReviewFeedViewController?
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    
    var food = PFObject(className: "Food")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starRating.settings.disablePanGestures = true
        let restaurant = food["restaurant"] as! PFObject
        let restName:String = restaurant["name"] as! String
        let foodStr:String = food["dishName"] as! String
        restaurantName.text = restName
        foodName.text = foodStr
        buildTextViewBorder()
        
        //Allow dismissal of keyboard
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        
    
        // Do any additional setup after loading the view.
    }
    func buildTextViewBorder(){
          let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
          reviewText.layer.borderWidth = 0.5
          reviewText.layer.borderColor = borderColor.cgColor
          reviewText.layer.cornerRadius = 5.0
      }
    @IBAction func onSubmit(_ sender: Any) {
        
        
                                
        let review = PFObject(className: "Review")
        
        review["author"] = PFUser.current()!
        review["review"] = reviewText.text!
        review["rating"] = starRating.rating
        review["foodReviewed"] = food
        var total = starRating.rating
        var num = 1
        
        if food["totalRating"] != nil {
            total += food["totalRating"] as! Double
        }
        if food["numRatings"] != nil {
            num += food["numRatings"] as! Int
        }
        let avg = total/Double(num)
        food["avgRating"] = avg
        food["totalRating"] = total
        food["numRatings"] = num
        food.saveInBackground()
        
        review.saveInBackground { (success, error) in
            if success {
                self.delegate?.refreshTable()
                self.dismiss(animated: true, completion: nil)
                
                print("Saved")
            } else {
                print("Error!")
            }
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
