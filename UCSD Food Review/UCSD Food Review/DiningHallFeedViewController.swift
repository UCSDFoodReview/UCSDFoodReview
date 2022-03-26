//
//  DiningHallFeedViewController.swift
//  UCSD Food Review
//
//  Created by David Em-Yinn on 3/12/22.
//

import UIKit
import Parse
import AlamofireImage

class DiningHallFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var diningHalls = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"DiningHall")
        query.includeKeys(["diningHallName", "description", "image"])
        query.limit = 10
        
        query.findObjectsInBackground { (diningHalls, error) in
            if diningHalls != nil {
                self.diningHalls = diningHalls!
                self.tableView.reloadData()
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diningHalls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiningHallCell") as! DiningHallCell
        
        let diningHall = diningHalls[indexPath.row]
        
        let name:String = diningHall["diningHallName"] as! String
        let description:String = diningHall["description"] as! String
        
        let imageFile = diningHall["image"] as! PFFileObject
        let imageURL = imageFile.url!
        let url = URL(string: imageURL)!
        cell.diningHallName.text = name
        cell.diningHallDescription.text = description
        
        cell.diningHallImage.af.setImage(withURL: url)
        
        cell.diningHallDescription.sizeToFit()
//        cell.diningHallName.text = "test!"
//        cell.diningHallDescription.text = "description!"
        
    /*    cell.diningHallName.text = "test"
        cell.diningHallDescription.text = "test desc"
        
        let testName = diningHall["diningHallName"] as? String
        print(testName)
      */
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let diningHall = diningHalls[indexPath.row]
        
        let RestaurantsViewController = segue.destination as! RestaurantsFeedViewController
        RestaurantsViewController.dininghall = diningHall
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
    }
    

}
