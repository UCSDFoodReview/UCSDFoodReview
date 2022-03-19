//
//  RatingsCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/19/22.
//

import UIKit

class RatingsCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var reviewFullName: UILabel!
    @IBOutlet weak var dateReviewed: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
