//
//  EachItemTableViewCell.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/21/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class EachItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var playlistButton: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var pubdate: UILabel!
}
