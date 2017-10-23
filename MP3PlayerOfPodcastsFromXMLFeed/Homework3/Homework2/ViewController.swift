//
//  ViewController.swift
//  Homework2
//
//  Created by Shehab, Mohamed on 10/5/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, XMLParserDelegate {

    
    var parser = XMLParser()
    
    
    var tempTitle : String = ""
    var tempMediaURL : String = ""

    var itemFlag = 0
    var titleFlag = 0
    var titleMediaURL = 0
    
    
    
    var allItems = [item] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myXMLparser()
    }
    
    
    func myXMLparser()  {
        
        
        let urlString = URL(string: "http://feed.thisamericanlife.org/talpodcast")
        self.parser = XMLParser(contentsOf: urlString!)!
        self.parser.delegate = self
        let success:Bool = self.parser.parse()
        if success {
            print("success")
        } else {
            print("parse failure!")
        }
        
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        
        if(elementName == "item")
        {
            itemFlag = 1
        }
        
        if(itemFlag==1 && elementName=="title")
        {
            titleFlag = 1
        }
        
        if(itemFlag == 1 && elementName=="media:content")
        {
            for string in attributeDict {
                let strvalue = string.value as String
                
                if(string.key == "url")
                {
                    tempMediaURL = strvalue
                }
            }
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if(elementName == "item")
        {
            itemFlag = 0
            
            if(tempMediaURL != "" && tempTitle != ""){
                let temp = item(title: tempTitle, mediaURL: tempMediaURL)
                allItems.append(temp)
            }
            
            
        }
        
        if(elementName == title)
        {
            titleFlag = 0
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if(titleFlag==1 && itemFlag==1)
        {
            tempTitle = string
        }
        
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
        
    }
    
    
    
    
    /////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

