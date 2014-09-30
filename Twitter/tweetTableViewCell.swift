//
//  tweetTableViewCell.swift
//  Twitter
//
//  Created by Kun Rong on 9/28/14.
//  Copyright (c) 2014 Kun Rong. All rights reserved.
//

import UIKit

class tweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweet_text: UILabel!
    @IBOutlet weak var created_At: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
