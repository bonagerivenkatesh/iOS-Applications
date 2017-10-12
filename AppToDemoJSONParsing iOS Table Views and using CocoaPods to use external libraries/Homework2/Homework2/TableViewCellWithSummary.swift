//
//  TableViewCellWithSummary.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/8/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class TableViewCellWithSummary: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var Ssquare: UIImageView!
    @IBOutlet weak var Stitle: UILabel!
    @IBOutlet weak var SdevName: UILabel!
    @IBOutlet weak var Srdate: UILabel!
    @IBOutlet weak var Sprice: UILabel!
    @IBOutlet weak var Ssummary: UILabel!
}
