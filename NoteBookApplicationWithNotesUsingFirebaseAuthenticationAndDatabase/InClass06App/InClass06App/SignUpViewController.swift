//
//  SignUpViewController.swift
//  InClass06App
//
//  Created by Bonageri, Venkatesh on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    let rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {
        
        if self.name.text == "" || self.email.text == "" || self.password.text == "" || self.confirmPassword.text == ""
        {
            
            let alert = UIAlertController(title: "Missing Fields", message: "Please Fill All the Fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if self.password.text != self.confirmPassword.text
        {
            
            let alert = UIAlertController(title: "Password Missmatch", message: "Password and Confirm Password should be same", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            
            Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!, completion: { (user, error) in
                if error == nil
                {
                    let userRef = self.rootRef.child("users")
                    
                    userRef.child((user?.uid)!).setValue(["Name": self.name.text!,"email": self.email.text!])
                    
                    /*
                     let alert = UIAlertController(title: "User Creation Success", message: "Hurray" , preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    */
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
                    self.present(NoteBookTableViewController, animated: true, completion: nil)
                    
                }
                else
                {
                    let alert = UIAlertController(title: "User Creation Failed", message: error?.localizedDescription , preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    

}
