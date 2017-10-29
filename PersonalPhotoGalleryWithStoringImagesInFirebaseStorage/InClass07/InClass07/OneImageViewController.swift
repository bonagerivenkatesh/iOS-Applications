//
//  OneImageViewController.swift
//  InClass07
//
//  Created by Bonageri, Venkatesh on 10/26/17.
//  Copyright © 2017 Sai Nishanth Dilly. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class OneImageViewController: UIViewController {

    var url = ""
    var key = ""
    
    let imagesRef = Storage.storage().reference().child("images");
    let rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        putImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var indImage: UIImageView!
    
    func putImage()  {
        
        indImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
    }

    @IBAction func removeImage(_ sender: UIBarButtonItem) {
        
        
        let deleteAlert = UIAlertController(title: "Photo Delete", message: "Do you want to delete this photo?", preferredStyle: UIAlertControllerStyle.alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            let tempS : String = self.key + ".png"
            
            self.imagesRef.child(tempS).delete{ error in
                if let error = error {
                    
                    print(error)
                    
                } else {
                    
                    self.rootRef.child("images").child((Auth.auth().currentUser?.uid)!).child(self.key).removeValue()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let GalleyCollectionViewController = storyboard.instantiateViewController(withIdentifier: "GalleyCollectionViewController") as! UINavigationController
                    self.present(GalleyCollectionViewController, animated: true, completion: nil)
                    
                }
            }
            
            
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        present(deleteAlert, animated: true, completion: nil)
        
        
    }
}
