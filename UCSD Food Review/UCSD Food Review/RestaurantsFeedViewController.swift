//
//  RestaurantsViewController.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit
import Parse
import AlamofireImage

class RestaurantsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dininghall = PFObject(className: "DiningHall")
    var restaurants = [PFObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Restaurant")
        query.whereKey("diningHall", equalTo:dininghall)
        query.includeKeys(["diningHall", "name"])
        query.limit = 8
        
        query.findObjectsInBackground { (restaurants, error) in
            if restaurants != nil {
                self.restaurants = restaurants!
                self.tableView.reloadData()
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
            let restaurant = restaurants[indexPath.row]
            
            let name:String = restaurant["name"] as! String
            
          
            let imageFile = dininghall["image"] as! PFFileObject
            let imageURL = imageFile.url!
            let url = URL(string: imageURL)!
            cell.restaurantImage.af.setImage(withURL: url)
            
            
            
            cell.restaurantName.text = name
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiningResHeaderCell") as! DiningResHeaderCell
            let name = dininghall["diningHallName"] as! String
            let desc = dininghall["description"] as! String
            
            let imageFile = dininghall["image"] as! PFFileObject
            let imageURL = imageFile.url!
            let url = URL(string: imageURL)!
            cell.diningHallImage.af.setImage(withURL: url)
            cell.diningHallName.text = name
            cell.diningHallDesc.text = desc
            cell.diningHallDesc.sizeToFit()
            
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let restCell = restaurants[indexPath.row]
        
        let FoodViewController = segue.destination as! FoodFeedViewController
        FoodViewController.restaurant = restCell
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
