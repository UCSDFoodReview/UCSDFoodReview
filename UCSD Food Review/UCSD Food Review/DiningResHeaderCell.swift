//
//  DiningResHeaderCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/28/22.
//

import UIKit

class DiningResHeaderCell: UITableViewCell {
    
    @IBOutlet weak var diningHallImage: UIImageView!
    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var diningHallDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        diningHallImage.layer.cornerRadius = 10.0

        // Configure the view for the selected state
    }

}
