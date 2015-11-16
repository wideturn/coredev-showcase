//
//  PostCell.swift
//  coreDev-Showcase
//
//  Created by Samuel Atwell on 11/15/15.
//  Copyright © 2015 CoreDev. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = 5.0
        profileImg.clipsToBounds = true
        
        showcaseImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
