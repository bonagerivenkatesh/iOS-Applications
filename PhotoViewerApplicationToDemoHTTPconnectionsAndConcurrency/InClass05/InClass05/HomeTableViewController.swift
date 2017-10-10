//
//  HomeTableViewController.swift
//  InClass05
//
//  Created by Bonageri, Venkatesh on 10/5/17.
//  Copyright © 2017 Bonageri, Venkatesh. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    var rowData = ["Animals", "News", "Entertainment", "Food and Drink", "Cars"]
    
    var indexfromInput: Int = -1;
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        let x = sender as? UITableViewCell
         let indexPath = self.tableView.indexPath(for: x!)!
        
        indexfromInput = indexPath[1]
        
        switch indexfromInput {
        case 0:
            let imageDisplay: ImageDisplayViewController = segue.destination as! ImageDisplayViewController
            imageDisplay.imageCategory = "animals"
        
        case 2:
            let imageDisplay: ImageDisplayViewController = segue.destination as! ImageDisplayViewController
            imageDisplay.imageCategory = "entertainment"
            
            
        case 1:
            let imageDisplay: ImageDisplayViewController = segue.destination as! ImageDisplayViewController
            imageDisplay.imageCategory = "news"
        
        
        case 3:
            let imageDisplay: ImageDisplayViewController = segue.destination as! ImageDisplayViewController
            imageDisplay.imageCategory = "food"
            
            
        case 4:
            let imageDisplay: ImageDisplayViewController = segue.destination as! ImageDisplayViewController
            imageDisplay.imageCategory = "car"
            
            
        default:break
            
        }
        
        
    }
    
    

    // MARK: - Table view data source

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowData.count
    }

    

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let celldata = rowData[indexPath.row]
        
        cell.textLabel?.text = celldata

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
