//
//  FoodDescRatingsCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/28/22.
//

import UIKit

class FoodDescRatingsCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodRating: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
