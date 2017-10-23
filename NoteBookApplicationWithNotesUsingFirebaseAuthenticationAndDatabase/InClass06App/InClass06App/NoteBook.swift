//
//  NoteBook.swift
//  InClass06App
//
//  Created by Bonageri, Venkatesh on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

class NoteBook{
    var Name:String = ""
    var Id:String = ""
    var Date:String = ""
    
    init(Name:String,Id:String,Date:String){
        self.Name = Name
        self.Id = Id
        self.Date = Date
    }
    
    init(){}
    
}
