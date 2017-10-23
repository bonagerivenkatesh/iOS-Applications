//
//  PlayListTableViewController.swift
//  Homework2
//
//  Created by Bonageri, Venkatesh on 10/21/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayListTableViewController: UITableViewController {

    var ReloadFlag = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PlayListTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        
        self.playerQueue.removeAllItems()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ItemTableViewController = storyboard.instantiateViewController(withIdentifier: "ItemTableViewController") as! UINavigationController
        self.present(ItemTableViewController, animated: false, completion: nil)
        
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
        
        return GlobalVar.playList.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = Bundle.main.loadNibNamed("EachItemTableViewCell", owner: self , options: nil)?.first as! EachItemTableViewCell
        
        cell.title.text = GlobalVar.playList[indexPath[1]].title
        cell.summary.text = GlobalVar.playList[indexPath[1]].summary
        
        cell.author.text = GlobalVar.playList[indexPath[1]].author
        cell.pubdate.text = GlobalVar.playList[indexPath[1]].pubDate
        
        cell.button.addTarget(self, action: #selector(ItemTableViewController.play(sender:)), for: .touchUpInside)
        cell.button.tag = indexPath.row
        
        
        cell.playlistButton.addTarget(self, action: #selector(ItemTableViewController.playlist(sender:)), for: .touchUpInside)
        
        
        for (key, value) in GlobalVar.plalistyCount {
            
            if(value == indexPath.row)
            {
                cell.playlistButton.tag = key
                break
            }
            
            
        }
    
        
        if(self.ReloadFlag != indexPath.row)
        {
            cell.button.setTitle("Play", for: UIControlState.normal)
        }
        else
        {
            cell.button.setTitle("Stop", for: UIControlState.normal)
        }
        
    
        cell.playlistButton.setTitle("Remove from Playlist", for: UIControlState.normal)
        
        
        
        return cell
    }
 
    
    @objc func playlist(sender: UIButton) {
        
        let tempindex = GlobalVar.plalistyCount[sender.tag]
        let url = URL(string: GlobalVar.playList[tempindex!].mediaURL)
        let playerItem = AVPlayerItem.init(url: url!)
        
        self.playerQueue.remove(playerItem)
        
        
        if((((self.playerQueue.currentItem?.asset) as? AVURLAsset)?.url) == url)
        {
            if(self.playerQueue.status.rawValue == 1){
                self.playerQueue.advanceToNextItem() }
        }
        
        
        
        for (key, value) in GlobalVar.plalistyCount {
            
            if(value > GlobalVar.plalistyCount[sender.tag]!)
            {
                GlobalVar.plalistyCount[key] = GlobalVar.plalistyCount[key]!-1
            }
            
        }
        
        GlobalVar.playList.remove(at: GlobalVar.plalistyCount[sender.tag]!)
        GlobalVar.plalistyCount[sender.tag] = -1
        tableView.reloadData()
        
        
        
}
    
    
    
    
    @IBOutlet weak var playAlllabel: UIBarButtonItem!
    
    
    @IBAction func playAll(_ sender: UIBarButtonItem) {
        
        self.playerQueue.removeAllItems()
        self.ReloadFlag = -1
        tableView.reloadData()
        
        
        if(sender.title == "Play All")
        {
            
            for tempItem in GlobalVar.playList {
                
                let url = URL(string: tempItem.mediaURL)
                
                let playerItem = AVPlayerItem.init(url: url!)
                self.playerQueue.insert(playerItem, after: nil)
                
            }
            
            playAlllabel.title = "Stop Playlist"
            
            self.playerQueue.play()
        }
        else if(sender.title == "Stop Playlist")
        {
            playAlllabel.title = "Play All"
        }
        
    }
    
    @objc func play(sender: UIButton) {
        
        
        playAlllabel.title = "Play All"
        
        if(sender.currentTitle == "Play")
        {
            self.playerQueue.removeAllItems()
            
            self.ReloadFlag = sender.tag
            
            tableView.reloadData()
            
            playMedia(urls: GlobalVar.playList[sender.tag].mediaURL)
            
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
