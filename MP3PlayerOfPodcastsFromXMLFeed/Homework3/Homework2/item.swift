//
//  item.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/21/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation

class item
{
    var title:String = ""
    var mediaURL:String = ""
    var summary:String = ""
    var author:String = ""
    var pubDate:String = ""
    
    init(title:String,mediaURL:String,summary:String,author:String,pubDate:String){
        self.title = title
        self.mediaURL = mediaURL
        self.summary = summary
        self.author = author
        self.pubDate = pubDate
        
    }
    
    init(){}
    
    
}
