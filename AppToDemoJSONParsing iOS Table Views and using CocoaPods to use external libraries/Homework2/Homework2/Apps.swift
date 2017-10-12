//
//  Apps.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/7/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation

class Apps{
    var Title:String = ""
    var DevName:String = ""
    var Rdate:String = ""
    var Price:Double = 0.0
    var squareImage:String = ""
    var otherImage:String = ""
    var summary:String = ""
    var category:String = ""
    
    
    
    init(Title:String,DevName:String,Rdate:String,Price:Double,squareImage:String,otherImage:String,summary:String,category:String){
        self.Title = Title
        self.DevName = DevName
        self.Rdate = Rdate
        self.Price = Price
        self.squareImage = squareImage
        self.otherImage = otherImage
        self.summary = summary
        self.category = category
    }
    
    init(){}
    
}
