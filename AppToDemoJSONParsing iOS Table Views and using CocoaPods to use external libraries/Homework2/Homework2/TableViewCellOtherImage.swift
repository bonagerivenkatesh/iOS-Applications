//
//  TableViewCellOtherImage.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/8/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class TableViewCellOtherImage: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var Osquare: UIImageView!
    @IBOutlet weak var Otitle: UILabel!
    @IBOutlet weak var Odevname: UILabel!
    @IBOutlet weak var Ordate: UILabel!
    @IBOutlet weak var Oprice: UILabel!
    @IBOutlet weak var Ootherimage: UIImageView!
}
