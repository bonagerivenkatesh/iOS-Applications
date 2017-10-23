//
//  NoteBookTableViewController.swift
//  InClass06App
//
//  Created by Bonageri, Venkatesh on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class NoteBookTableViewController: UITableViewController {
    
    let rootRef = Database.database().reference()
    
    var noteBooks = [NoteBook] ()


    @IBAction func newNoteBook(_ sender: UIBarButtonItem) {
        
        let noteBooksRef = rootRef.child("notebooks").child((Auth.auth().currentUser?.uid)!)
        
        let alert = UIAlertController(title: "New Notebook", message: "Enter new Notebook Name", preferredStyle: .alert)
        
       
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Notebook name"
        })
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
        
            
            let cDate = NSDate()
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.long
            dateFormatter.timeStyle = .medium
            let now = dateFormatter.string(from: cDate as Date)
            
            
            noteBooksRef.childByAutoId().setValue(["notebookname": textField.text!,"createdDate": now])
            
            self.tableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        }))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 76.5
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    
    func getNewData()  {
        
        self.noteBooks = [NoteBook]()
        
        let noteBooksRef = rootRef.child("notebooks").child((Auth.auth().currentUser?.uid)!)
        
        noteBooksRef.observe(.value, with: { (snapshot) -> Void in
            
            self.noteBooks = [NoteBook]()
            
            let enumerator = snapshot.children
            

            
            while let eachData = enumerator.nextObject() as? DataSnapshot {
            
                let tempkey : String = eachData.key
                
                let tempName : String = eachData.childSnapshot(forPath: "notebookname").value as! String
                
                let tempDate : String = eachData.childSnapshot(forPath: "createdDate").value as! String
                
                let temp = NoteBook(Name: tempName, Id: tempkey, Date: tempDate)
                
                self.noteBooks.append(temp)

            }
            self.tableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        getNewData()
        
    }
    

    @IBAction func logout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(LoginViewController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        // Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        cell.textLabel?.text = noteBooks[indexPath[1]].Name
        cell.detailTextLabel?.text = noteBooks[indexPath[1]].Date
        
        return cell
        
    }
    
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
       
        return noteBooks.count
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "notesForNoteBook"{
            if let destination = segue.destination as? NotesTableViewController {
                destination.NoteBookKey = self.noteBooks[(tableView.indexPathForSelectedRow?.row)!].Id
            }
        }
        
    }
    
}
