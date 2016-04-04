//
//  FeedCell.swift
//  Instagram
//
//  Created by David Santiago on 4/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
