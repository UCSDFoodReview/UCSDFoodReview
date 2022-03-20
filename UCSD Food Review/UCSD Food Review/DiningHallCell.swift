//
//  DiningHallCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit

class DiningHallCell: UITableViewCell {

    @IBOutlet weak var diningHallImage: UIImageView!
    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var diningHallLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
