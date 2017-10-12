//
//  TableViewCellWithout.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/8/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class TableViewCellWithout: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var WsquareImage: UIImageView!
    @IBOutlet weak var Wtitle: UILabel!
    @IBOutlet weak var WdevName: UILabel!
    @IBOutlet weak var Wrdate: UILabel!
    @IBOutlet weak var Wprice: UILabel!
}
