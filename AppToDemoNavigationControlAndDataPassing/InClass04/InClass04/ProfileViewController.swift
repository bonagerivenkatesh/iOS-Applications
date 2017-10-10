//
//  ProfileViewController.swift
//  InClass04
//
//  Created by Bonageri, Venkatesh on 9/28/17.
//  Copyright © 2017 Bonageri, Venkatesh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userObj:Users = Users()
    
    @IBOutlet weak var passVisibility: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pName.text = userObj.Name
        pEmail.text = userObj.Email
        
        pDepartment.text = userObj.Department
        
        let passStar = String(repeating: "*", count: userObj.Password.count)
        pPassword.text = passStar
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var pName: UILabel!
    
    @IBOutlet weak var pEmail: UILabel!
    @IBOutlet weak var pPassword: UILabel!
    
    @IBOutlet weak var pDepartment: UILabel!
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if let sourceVC = segue.source as? editNameViewController{
            pName.text = sourceVC.etName.text
            userObj.Name = sourceVC.etName.text!
        }
        
        if let sourceVC = segue.source as? editEmailViewController{
            pEmail.text = sourceVC.etEmail.text
            userObj.Email = sourceVC.etEmail.text!
        }
        
        if let sourceVC = segue.source as? editPasswordViewController{
            
            
            userObj.Password = sourceVC.etPassword.text!
            
            if passVisibility.currentTitle == "Show"{
                
                let passStar = String(repeating: "*", count: userObj.Password.count)
                pPassword.text = passStar
                
            }else{
                pPassword.text = sourceVC.etPassword.text
            }
            
            
        }
        
       
        
        if let sourceVC = segue.source as? editDepartmentViewController{
            pDepartment.text = sourceVC.deparment
            userObj.Department = sourceVC.deparment
        }
        
        
        
    }
    
    @IBAction func passVisibility(_ sender: UIButton) {
        
        
        if sender.currentTitle == "Show" {
            pPassword.text = userObj.Password
            
            sender.setTitle("Hide", for: UIControlState.normal)
        }
        
        else if sender.currentTitle == "Hide" {
            
            let passStar = String(repeating: "*", count: userObj.Password.count)
            
            pPassword.text = passStar
            sender.setTitle("Show", for: UIControlState.normal)
            
        }
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "updateName":
            let updateNameVC: editNameViewController = segue.destination as! editNameViewController
            updateNameVC.editNameString = userObj.Name
        case "updateEmail":
            let updateEmailVC: editEmailViewController = segue.destination as! editEmailViewController
            updateEmailVC.editEmailString = userObj.Email
        case "updatePassword":
            let updatePasswordVC: editPasswordViewController = segue.destination as! editPasswordViewController
            updatePasswordVC.editPasswordString = userObj.Password
        case "updateDepartment":
            let updateDepartmentVC: editDepartmentViewController = segue.destination as! editDepartmentViewController
            updateDepartmentVC.deparment = userObj.Department
        
        default:break
            
        }
        
        
    }
    
    
    

}
