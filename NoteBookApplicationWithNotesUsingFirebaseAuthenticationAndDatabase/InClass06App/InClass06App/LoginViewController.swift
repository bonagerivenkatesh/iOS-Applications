//
//  LoginViewController.swift
//  InClass06App
//
//  Created by Bonageri, Venkatesh on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        // Do any additional setup after loading the view.
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
                self.present(NoteBookTableViewController, animated: true, completion: nil)
            }
        }
    }

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func Login(_ sender: UIButton) {
        
        if self.email.text == "" || self.password.text == ""
        {
            let alert = UIAlertController(title: "Empty Fields", message: "Fill all the fields" , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: { (user, error) in
                if error == nil
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
                    self.present(NoteBookTableViewController, animated: true, completion: nil)
                }
                else
                {
                    let alert = UIAlertController(title: "Couldn't Login", message: error?.localizedDescription , preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
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
