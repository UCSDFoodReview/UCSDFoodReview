//
//  FoodCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodRating: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        myView.layer.cornerRadius = 12.0
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        myView.layer.shadowRadius = 6.0
        myView.layer.shadowOpacity = 0.3

        // Configure the view for the selected state
    }

}
