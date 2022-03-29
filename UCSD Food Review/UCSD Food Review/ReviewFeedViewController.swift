//
//  ReviewFeedViewController.swift
//  UCSD Food Review
//
//  Created by Brian on 3/28/22.
//

import UIKit
import Parse
import AlamofireImage
import Foundation

class ReviewFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var foodReviewed = PFObject(className: "Food")
    
    var reviewList = [PFObject]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Review")
        query.whereKey("foodReviewed", equalTo:foodReviewed)
        query.includeKeys(["createdAt", "review", "rating", "author"])
        query.limit = 100
        
        query.findObjectsInBackground {
            (reviewList, error) in
            if reviewList != nil {
                self.reviewList = reviewList!
                self.tableView.reloadData()
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDescRatingsCell") as! FoodDescRatingsCell
            let name:String = foodReviewed["dishName"] as! String
            let price:Float = foodReviewed["price"] as! Float
            let strPrice = price.description
            var strRating = "0"
            if foodReviewed["avgRating"] != nil {
                let avgRating = foodReviewed["avgRating"] as! Float
                strRating = avgRating.description
            }
            cell.foodName.text = name
            cell.foodPrice.text = strPrice
            cell.foodRating.text = strRating
            
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewButtonCell") as! ReviewButtonCell
            let currUser = PFUser.current()!
            let imageFile = currUser["profilePhoto"] as! PFFileObject
            let imageURL = imageFile.url!
            let url = URL(string: imageURL)!
            cell.userPFP.af.setImage(withURL: url)
            
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingsCell") as! RatingsCell
            let review = reviewList[indexPath.row]
            
            let author = review["author"] as! PFUser
            
            let imageFile = author["profilePhoto"] as! PFFileObject
            let imageURL = imageFile.url!
            let url = URL(string: imageURL)!
            let name:String = author["fullname"] as! String
            let date:Date = review["createdAt"] as! Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm/dd/YY"
            
            let reviewText:String = review["review"] as! String
            
            cell.userProfileImage.af.setImage(withURL: url)
            cell.reviewFullName.text = name
            cell.dateReviewed.text = dateFormatter.string(from: date)
            cell.reviewText.text = reviewText
            
            return cell
            
            
            
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
