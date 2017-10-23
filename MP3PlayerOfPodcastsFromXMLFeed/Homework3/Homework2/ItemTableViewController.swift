//
//  ItemTableViewController.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/21/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation



struct GlobalVar {
    static var playList = [item] ()
    static var plalistyCount = [Int: Int]()
    
}

class ItemTableViewController: UITableViewController, XMLParserDelegate {

    
    var parser = XMLParser()
    
    
    var tempTitle : String = ""
    var tempMediaURL : String = ""
    var tempSummary : String = ""
    var tempPubDate : String = ""
    var tempAuthor : String = ""
    
    var itemFlag = 0
    var titleFlag = 0
    var summaryFlag = 0
    var pubDateFlag = 0
    var authorFlag = 0
    
    var allItems = [item] ()
    
    
    var ReloadFlag = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 116.5
        
        myXMLparser()
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension;
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
        
        else if(itemFlag==1 && elementName=="title")
        {
            titleFlag = 1
        }
        
        else if(itemFlag == 1 && elementName=="media:content")
        {
            for string in attributeDict {
                let strvalue = string.value as String
                
                if(string.key == "url")
                {
                    tempMediaURL = strvalue
                }
            }
        }
        else if(itemFlag == 1 && elementName == "itunes:summary")
        {
            summaryFlag = 1
        }
        else if(itemFlag == 1 && elementName == "itunes:author")
        {
            authorFlag = 1
        }
        else if(itemFlag == 1 && elementName == "pubDate")
        {
            pubDateFlag = 1
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if(elementName == "item")
        {
            itemFlag = 0
            
            if(tempMediaURL != "" && tempTitle != ""){
                
                let Cutindex = tempPubDate.index(tempPubDate.startIndex, offsetBy: 16)
                tempPubDate = tempPubDate.substring(to: Cutindex)
                tempPubDate = "Published On " + tempPubDate
                
                tempAuthor = "Author: " + tempAuthor
                
                let temp = item(title: tempTitle, mediaURL: tempMediaURL, summary : tempSummary, author : tempAuthor, pubDate : tempPubDate)
                allItems.append(temp)
                
                tempSummary = ""
                tempTitle = ""
                tempMediaURL = ""
                tempAuthor = ""
                tempPubDate = ""
            }
            
            
        }
        
        if(elementName == "title")
        {
            titleFlag = 0
            
        }
        
        if(elementName == "itunes:summary")
        {
            summaryFlag = 0
            
        }
        
        if(elementName == "pubDate")
        {
            pubDateFlag = 0
        }
        
        if(elementName == "itunes:author")
        {
            authorFlag = 0
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if(titleFlag==1 && itemFlag==1)
        {
            tempTitle =  tempTitle + string
            
        }
        else if(itemFlag == 1 && summaryFlag==1)
        {
            
            tempSummary = tempSummary + string
            
        }
        else if(itemFlag == 1 && pubDateFlag==1)
        {
            
            tempPubDate = tempPubDate + string
            
        }
        else if(itemFlag == 1 && authorFlag==1)
        {
            
            tempAuthor = tempAuthor + string
            
        }
        
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allItems.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        // Configure the cell...
        
        
        let cell = Bundle.main.loadNibNamed("EachItemTableViewCell", owner: self , options: nil)?.first as! EachItemTableViewCell
        
        cell.title.text = allItems[indexPath[1]].title
        cell.summary.text = allItems[indexPath[1]].summary
        
        cell.author.text = allItems[indexPath[1]].author
        cell.pubdate.text = allItems[indexPath[1]].pubDate
        
        cell.button.addTarget(self, action: #selector(ItemTableViewController.play(sender:)), for: .touchUpInside)
        cell.button.tag = indexPath.row
        
        
        cell.playlistButton.addTarget(self, action: #selector(ItemTableViewController.playlist(sender:)), for: .touchUpInside)
        cell.playlistButton.tag = indexPath.row
        
        
        
        if(self.ReloadFlag != indexPath.row)
        {
            cell.button.setTitle("Play", for: UIControlState.normal)
        }
        else
        {
            cell.button.setTitle("Stop", for: UIControlState.normal)
        }
        
        
        if(!GlobalVar.plalistyCount.keys.contains(indexPath.row))
        {
            GlobalVar.plalistyCount[indexPath.row] = -1
            
            cell.playlistButton.setTitle("Add to Playlist", for: UIControlState.normal)
            
        }
        else if(GlobalVar.plalistyCount[indexPath.row] == -1)
        {
            cell.playlistButton.setTitle("Add to Playlist", for: UIControlState.normal)
        }
        else
        {
            cell.playlistButton.setTitle("Remove from Playlist", for: UIControlState.normal)
        }
        
        
        return cell

    }
    
    
    @objc func playlist(sender: UIButton) {
    
        if(sender.currentTitle == "Add to Playlist")
        {
            let tempItem = allItems[sender.tag]
            GlobalVar.playList.append(tempItem)
            
            GlobalVar.plalistyCount[sender.tag] = GlobalVar.playList.count - 1
            
            tableView.reloadData()
        }
        else if(sender.currentTitle == "Remove from Playlist")
        {
            
            GlobalVar.playList.remove(at: GlobalVar.plalistyCount[sender.tag]!)
            
            for (key, value) in GlobalVar.plalistyCount {
            
                if(value > GlobalVar.plalistyCount[sender.tag]!)
                {
                    GlobalVar.plalistyCount[key] = GlobalVar.plalistyCount[key]!-1
                }
                
            
            }
            
            GlobalVar.plalistyCount[sender.tag] = -1
            
            
            tableView.reloadData()
            
            
        }
        
        
    }
    
    
    
    @objc func play(sender: UIButton) {
     
        if(sender.currentTitle == "Play")
        {
            self.playerQueue.removeAllItems()
            
            self.ReloadFlag = sender.tag
            
            tableView.reloadData()
            
            playMedia(urls: allItems[sender.tag].mediaURL)
            
            
            
        }
        else if(sender.currentTitle == "Stop")
        {
            self.playerQueue.removeAllItems()
            
            self.ReloadFlag = -1
            
            tableView.reloadData()
        }
        
        
        
    }
    
    lazy var playerQueue : AVQueuePlayer = {
        return AVQueuePlayer()
    }()
    
    
    func playMedia(urls : String)  {
        
        
        let url = URL(string: urls)
        
        let playerItem = AVPlayerItem.init(url: url!)
        self.playerQueue.insert(playerItem, after: nil)
        self.playerQueue.play()
    
    }

}
