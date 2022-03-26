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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let restaurant = restaurants[indexPath.row]
        
        let name:String = restaurant["name"] as! String
        
        let imageFile = restaurant["diningHall"]["image"] as! PFFileObject
        let imageURL = imageFile.url!
        let url = URL(string: imageURL)!
        cell.restaurantImage.af.setImage(withURL: url)
        
        
        
        cell.restaurantName.text = name
        
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
