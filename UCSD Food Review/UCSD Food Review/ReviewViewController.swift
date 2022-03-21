//
//  ReviewViewController.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit
import Cosmos

class ReviewViewController: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starRating.settings.disablePanGestures = true

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
