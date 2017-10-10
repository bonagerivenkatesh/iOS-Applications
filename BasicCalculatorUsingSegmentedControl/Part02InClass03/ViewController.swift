//
//  ViewController.swift
//  Part02InClass03
//
//  Created by Bonageri, Venkatesh on 9/21/17.
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
    
 

    @IBOutlet weak var number1: UITextField!
    

    
    @IBOutlet weak var number2: UITextField!
    

    @IBOutlet weak var result: UILabel!
    
    
    @IBOutlet weak var mathop: UISegmentedControl!
    
    func validateNumber() -> Bool {
        
        if Double(number1.text!) == nil || Double(number1.text!) == nil {
            
            let alert = UIAlertController(title: "Invalid Input", message: "Enter Correct Input", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Sure", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            number1.text = String("")
            number2.text = String("")
            
            return false
        }
        else{
            return true
        }
    }
    
    
    func validateNumberDiv() -> Bool {
        
        if Double(number1.text!) == nil || Double(number1.text!) == nil {
            
            let alert = UIAlertController(title: "Invalid Input", message: "Enter Correct Input", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Sure", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            number1.text = String("")
            number2.text = String("")
            
            return false
        }
        else if Double(number2.text!)! == 0.00 {
            
            let alert = UIAlertController(title: "Invalid Input", message: "Divide by 0 is impossible", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            number2.text = String("")
            
            return false
        }
        else{
            return true
        }
    }

    
    @IBAction func clearall(_ sender: Any)
    {
        number1.text=""
        number2.text=""
        result.text = "0.00"
    }
    
    
    @IBAction func perform(_ sender: Any)
    {
        if (mathop.selectedSegmentIndex == 0)
        {
            
            if(validateNumber())
            {
                
                let resultcal = Double(number1.text!)! + Double(number2.text!)!
                result.text = String(resultcal)
            }
            
        }
        else if (mathop.selectedSegmentIndex == 1)
        {
            if(validateNumber())
            {
                let resultcal = Double(number1.text!)! - Double(number2.text!)!
                result.text = String(resultcal)
            }
            
        }
        else if (mathop.selectedSegmentIndex == 2)
        {
            if(validateNumber())
            {
                let resultcal = Double(number1.text!)! * Double(number2.text!)!
                result.text = String(resultcal)
            }
            
        }
        else if (mathop.selectedSegmentIndex == 3)
        {
            if(validateNumberDiv())
            {
                let resultcal = Double(number1.text!)! / Double(number2.text!)!
                result.text = String(resultcal)
            }
            
        }

    }
    
}

