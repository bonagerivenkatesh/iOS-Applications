//
//  editDepartmentViewController.swift
//  InClass04
//
//  Created by Bonageri, Venkatesh on 9/28/17.
//  Copyright © 2017 Bonageri, Venkatesh. All rights reserved.
//

import UIKit

class editDepartmentViewController: UIViewController {


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    
    @IBOutlet weak var updateDep: UISegmentedControl!
    
    var deparment:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if deparment == "CS"{
            updateDep.selectedSegmentIndex = 0
        }
        
        if deparment == "SIS"{
            updateDep.selectedSegmentIndex = 1
        }
        
        if deparment == "BIO"{
            updateDep.selectedSegmentIndex = 2
        }
    }
    
  
    @IBAction func updateDepartment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: deparment = "CS"
        case 1: deparment = "SIS"
        case 2: deparment = "BIO"
        default: break
        }
    }
    


}
