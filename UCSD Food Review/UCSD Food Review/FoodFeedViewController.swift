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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
