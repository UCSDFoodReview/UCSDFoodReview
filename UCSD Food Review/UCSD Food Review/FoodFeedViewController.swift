//
//  FoodFeedViewController.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit
import Parse
import AlamofireImage


class FoodFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var restaurant = PFObject(className: "Restaurant")
    
    var foodList = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Food")
        query.whereKey("restaurant", equalTo:restaurant)
        query.includeKeys(["dishName", "price", "avgRating", "numRating", "totalRating"])
        query.limit = 40
        
        query.findObjectsInBackground {
            (foodList, error) in
            if foodList != nil {
                self.foodList = foodList!
                self.tableView.reloadData()
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
            let food = foodList[indexPath.row]
            
            let name:String = food["dishName"] as! String
            
            let price:Float = food["price"] as! Float
            let strPrice = price.description
            
            var strRating = "0"
            if food["avgRating"] != nil {
                let avgRating = food["avgRating"] as! Float
                strRating = avgRating.description
            }
            
            
            
            
            cell.foodName.text = name
            cell.foodPrice.text = strPrice
            cell.foodRating.text = strRating
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestHeaderCell") as! RestHeaderCell
            let name:String = restaurant["name"] as! String
            let dininghall = restaurant["diningHall"] as! PFObject
            let imageFile = dininghall["image"] as! PFFileObject
            let imageURL = imageFile.url!
            let url = URL(string: imageURL)!
            cell.restName.text = name
            cell.restImage.af.setImage(withURL: url)
            
            return cell
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let foodCell = foodList[indexPath.row]
        
        let ReviewViewController = segue.destination as! ReviewFeedViewController
        ReviewViewController.foodReviewed = foodCell

    }
         
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodCell = foodList[indexPath.row]
        
        let destVC = ReviewFeedViewController()
        destVC.foodReviewed = foodCell
        
        destVC.performSegue(withIdentifier: "foodSegue", sender: self)
    }
    
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
