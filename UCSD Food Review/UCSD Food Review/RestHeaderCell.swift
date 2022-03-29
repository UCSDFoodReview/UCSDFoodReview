//
//  RestHeaderCell.swift
//  UCSD Food Review
//
//  Created by Brian on 3/28/22.
//

import UIKit

class RestHeaderCell: UITableViewCell {

    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        restImage.layer.cornerRadius = 10.0
        
        // Configure the view for the selected state
    }

}
