//
//  NotesTableViewController.swift
//  InClass06App
//
//  Created by Bonageri, Venkatesh on 10/21/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class NotesTableViewController: UITableViewController {
    
    var NoteBookKey : String = ""
    
    let rootRef = Database.database().reference()
    
    var notes = [NoteBook] ()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NotesTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton

    }
    
    @objc func back(sender: UIBarButtonItem) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
        self.present(NoteBookTableViewController, animated: false, completion: nil)
        
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
         return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       

        // Configure the cell...
        
        
        let cell = Bundle.main.loadNibNamed("NotesTableViewCell", owner: self , options: nil)?.first as! NotesTableViewCell
        
        cell.NoteDetails.text = notes[indexPath[1]].Name
        cell.createdAt.text = notes[indexPath[1]].Date
        
        cell.deleteNoteOut.addTarget(self, action: #selector(NotesTableViewController.deleteNote(sender:)), for: .touchUpInside)
        cell.deleteNoteOut.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension;
    }
    
    
    @objc func deleteNote(sender: UIButton) {
        
        let notesRef = rootRef.child("notebooks").child((Auth.auth().currentUser?.uid)!).child(NoteBookKey).child("Notes")
        
        notesRef.child(notes[sender.tag].Id).removeValue()
        
        getNewData()
        
    }
 

    @IBAction func AddNote(_ sender: UIBarButtonItem) {
    
        let notesRef = rootRef.child("notebooks").child((Auth.auth().currentUser?.uid)!).child(NoteBookKey).child("Notes")
        
        let alert = UIAlertController(title: "New Note", message: "Enter new Post Detail", preferredStyle: .alert)
        
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Note text"
        })
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            
            
            let cDate = NSDate()
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.long
            dateFormatter.timeStyle = .medium
            let now = dateFormatter.string(from: cDate as Date)
            
            
            notesRef.childByAutoId().setValue(["note": textField.text!,"createdDate": now])
            
            self.tableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    
    
    }
    
    
    func getNewData()  {
        
        self.notes = [NoteBook]()
        
        let notesRef = rootRef.child("notebooks").child((Auth.auth().currentUser?.uid)!).child(NoteBookKey).child("Notes")
        
        notesRef.observe(.value, with: { (snapshot) -> Void in
            
            self.notes = [NoteBook]()
            
            let enumerator = snapshot.children
            
            
            
            while let eachData = enumerator.nextObject() as? DataSnapshot {
                
                let tempkey : String = eachData.key
                
                let tempName : String = eachData.childSnapshot(forPath: "note").value as! String
                
                let tempDate : String = eachData.childSnapshot(forPath: "createdDate").value as! String
                
                let temp = NoteBook(Name: tempName, Id: tempkey, Date: tempDate)
                
                self.notes.append(temp)
                
            }
            self.tableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        getNewData()
        
    }
    

}
