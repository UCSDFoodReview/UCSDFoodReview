//
//  ReviewButtonCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/28/22.
//

import UIKit

class ReviewButtonCell: UITableViewCell {

    @IBOutlet weak var userPFP: UIImageView!
    
    @IBOutlet weak var myView: UIView!
    
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
        userPFP.layer.cornerRadius = userPFP.layer.bounds.width / 2
        userPFP.clipsToBounds = true
        userPFP.layer.borderColor = UIColor.darkGray.cgColor
        userPFP.layer.borderWidth = 2.0

        // Configure the view for the selected state
    }

}
