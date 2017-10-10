//
//  Users.swift
//  InClass04
//
//  Created by Bonageri, Venkatesh on 9/28/17.
//  Copyright © 2017 Bonageri, Venkatesh. All rights reserved.
//

import Foundation

class Users{
    var Name:String = ""
    var Email:String = ""
    var Password:String = ""
    var Department:String = ""
    
    init(Name:String,Email:String,Password:String,Department:String){
        self.Department = Department
        self.Email = Email
        self.Name = Name
        self.Password = Password
    }
    
    init(){}

}
