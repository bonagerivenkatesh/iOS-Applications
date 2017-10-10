//
//  ViewController.swift
//  InClass04
//
//  Created by Bonageri, Venkatesh on 9/28/17.
//  Copyright © 2017 Bonageri, Venkatesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var uName: UITextField!
    
    @IBOutlet weak var uEmail: UITextField!
    @IBOutlet weak var uPassword: UITextField!
    
    var department = "CS"
    
    @IBOutlet weak var uDepartment: UISegmentedControl!
    
    @IBAction func uDepartment(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex{
        case 0: department = "CS"
        case 1: department = "SIS"
        case 2: department = "BIO"
        default: break
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if(uName.text?.count != 0 && uEmail.text?.count != 0 && uPassword.text?.count != 0){
            return true;
        
        }
        else{
            
            let alert = UIAlertController(title: "Empty Fields", message: "Please fill all the details", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false;
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let profileVC: ProfileViewController = segue.destination as! ProfileViewController
        
            let usObj = Users(Name: uName.text!, Email: uEmail.text!, Password: uPassword.text!, Department: department)
            
            profileVC.userObj = usObj
            
        
        
    }
    
}

