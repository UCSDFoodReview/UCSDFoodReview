//
//  RestaurantCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit

class RestaurantCell: UITableViewCell {

    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
