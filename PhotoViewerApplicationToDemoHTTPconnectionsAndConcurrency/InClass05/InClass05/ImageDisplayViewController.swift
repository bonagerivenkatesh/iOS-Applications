//
//  ImageDisplayViewController.swift
//  InClass05
//
//  Created by Bonageri, Venkatesh on 10/5/17.
//  Copyright © 2017 Bonageri, Venkatesh. All rights reserved.
//



import UIKit

class ImageDisplayViewController: UIViewController {

    
    var curr = 0
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var myImage: UIImageView!
    var imageCategory : String = ""
    var count : Int = 0
    
    @IBOutlet weak var nextButtonenabledisable: UIButton!
    
    @IBOutlet weak var prevButtonenabledisable: UIButton!
    @IBOutlet weak var testlabel2: UILabel!
    
    
    func getmycount()  {
        
        let createURL : String = "http://dev.theappsdr.com/lectures/inclass_http/photos.php?count=get&category=\(imageCategory)"

        let urlcount = URL(string:createURL)
        
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let contents = try? Data(contentsOf: urlcount!)
            if let imageData = contents {
                DispatchQueue.main.sync {
                    var temp = String(data: contents!, encoding: String.Encoding.utf8)!
                    self?.count = Int(temp)!
                }
            }
        }
        
    }
    
    func getMyImage()  {
        
        let s : String  = "http://dev.theappsdr.com/lectures/inclass_http/photos.php?category=\(imageCategory)&pid=\(curr)"
        print(s)
        let url = URL(string:s)
        
        spinner.startAnimating()
        nextButtonenabledisable.isEnabled = false
        prevButtonenabledisable.isEnabled = false
        
        DispatchQueue.global(qos: .userInitiated).async {
            let urlContents = try? Data(contentsOf: url!)
            
            if let imageData = urlContents {
                
                DispatchQueue.main.async {
                    
                    self.myImage.image = UIImage(data: imageData)
                    
                    self.nextButtonenabledisable.isEnabled = true
                    self.prevButtonenabledisable.isEnabled = true
                    
                    self.spinner.stopAnimating()
                    
                }
            }
            
        }
        
        
    }
    
    

    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getmycount()
        
        
        
        if(imageCategory == "animals"){
            self.title = "Animals"}
        if(imageCategory == "news"){
            self.title = "NEWS"}
        if(imageCategory == "entertainment"){
            self.title = "Entertainment"}
        if(imageCategory == "food"){
            self.title = "Food and Drink"}
        if(imageCategory == "car"){
            self.title = "Cars"}
       
        getMyImage()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func prevImage(_ sender: Any) {
    
        
        if(curr == 0)
        {
            curr = count-1
        }
        else
        {
            curr = curr - 1
        }
        
        
        getMyImage()
    
    }
    
    
    @IBAction func nextImage(_ sender: Any) {
    
        if(curr == count-1)
        {
            curr = 0
        }
        else
        {
            curr = curr+1
        }
        
    
        getMyImage()
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
