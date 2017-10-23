//
//  NotesTableViewCell.swift
//  InClass06App
//
//  Created by Bonageri, Venkatesh on 10/21/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var NoteDetails: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var deleteNoteOut: UIButton!
    }
