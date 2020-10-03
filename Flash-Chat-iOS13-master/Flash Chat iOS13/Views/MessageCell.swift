//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Yurii Sameliuk on 19/11/2019.
//  Copyright © 2019 Sameliuk Yurii. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    // poxoguj na viewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        // delaem zaokryglennue yglu w sozdanoi nami ja4ejke 
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
