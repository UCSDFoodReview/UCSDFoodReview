//
//  DiningHallFeedViewController.swift
//  UCSD Food Review
//
//  Created by David Em-Yinn on 3/12/22.
//

import UIKit
import Parse
import Alamofire

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
        
        print("this ran!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diningHalls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiningHallCell") as! DiningHallCell
        
        let diningHall = diningHalls[indexPath.row]
//        cell.diningHallName.text = diningHall["diningHallName"] as? String
//        cell.diningHallDescription.text = diningHall["description"] as? String
        cell.diningHallName.text = "test!"
        cell.diningHallDescription.text = "description!"
        
        print(diningHall)
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
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
    }
    

}
