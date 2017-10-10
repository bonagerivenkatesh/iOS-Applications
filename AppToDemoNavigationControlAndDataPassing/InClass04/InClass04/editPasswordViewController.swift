//
//  editPasswordViewController.swift
//  InClass04
//
//  Created by Bonageri, Venkatesh on 9/28/17.
//  Copyright © 2017 Bonageri, Venkatesh. All rights reserved.
//

import UIKit

class editPasswordViewController: UIViewController {

    var editPasswordString : String = ""
    
    @IBOutlet weak var etPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        etPassword.text = editPasswordString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if etPassword.text?.count != 0{
            return true
        }
        else{
            
            let alert = UIAlertController(title: "Empty Password Field", message: "Please fill the Password Field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//

