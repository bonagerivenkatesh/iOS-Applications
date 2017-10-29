//
//  GalleryViewController.swift
//  InClass07
//
//  Created by Bonageri, Venkatesh on 10/26/17.
//  Copyright © 2017 Sai Nishanth Dilly. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let rootRef = Database.database().reference()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    let imagesRef = Storage.storage().reference().child("images");
    
    var images = [String] ()
     var keys = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = rootRef.child("users").child((Auth.auth().currentUser?.uid)!)
        
        
        user.observe(.value, with: {(snapshot) -> Void in
        
            let nameUser = snapshot.childSnapshot(forPath: "name").value as! String
            
            self.title = nameUser + " Photos"
        
        })
        
        
        
        rootRef.observe(.value, with: { (snapshot) -> Void in
        
            
            
            
            let imageRefForAssign = self.rootRef.child("images").child((Auth.auth().currentUser?.uid)!)
            
            
            imageRefForAssign.observe(.value, with: { (snapshot) -> Void in
                
                self.images = [String]()
                self.keys = [String]()
                
                let enumerator = snapshot.children
                
                
                
                while let eachData = enumerator.nextObject() as? DataSnapshot {
                    
                    
                    
                    let tempkey : String = eachData.key
                    self.keys.append(tempkey)
                    
                    let tempString : String = eachData.childSnapshot(forPath: "url").value as! String
                    self.images.append(tempString)
                    
                }
                
            })
            
            
            
            self.MyCollection.reloadData()
            
        
        
        })
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        getData()
        
        self.MyCollection.reloadData()
        
        
    }
    
 
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
    
        try! Auth.auth().signOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(LoginViewController, animated: true, completion: nil)
        
        
    
    }
    
    
    
    @IBOutlet weak var MyCollection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
            let imageName = NSUUID().uuidString
            let eachimageref = imagesRef.child("\(imageName).png")
        
        
        var selectedImg: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImg = originalImage
            
        }
      
        
        let upLoadData = UIImagePNGRepresentation(selectedImg!)
        
        eachimageref.putData(upLoadData!, metadata: nil, completion:
        { (metadata, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            if let urlOfImage = metadata?.downloadURL()?.absoluteString {
                
                
                
                self.rootRef.child("images").child((Auth.auth().currentUser?.uid)!).child(imageName).setValue(["url": urlOfImage])
                
            }
            
        })
       
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: UIBarButtonItem) {
    
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        
        present(controller, animated: true, completion: nil)
    
    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCellCollectionViewCell
        
        
        cell.myImage.sd_setImage(with: URL(string: images[indexPath.row]), placeholderImage: UIImage(named: "placeholder.png"))
       
        
       
       
        
        return cell
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func getData() {
        
        indicator.startAnimating()
       
        
        let imageRefForAssign = rootRef.child("images").child((Auth.auth().currentUser?.uid)!)
        
        imageRefForAssign.observe(.value, with: { (snapshot) -> Void in
            
            self.images = [String]()
            self.keys = [String]()
            
            let enumerator = snapshot.children
            
            
            
            while let eachData = enumerator.nextObject() as? DataSnapshot {
                
                let tempkey : String = eachData.key
                self.keys.append(tempkey)
                
                let tempString : String = eachData.childSnapshot(forPath: "url").value as! String
                self.images.append(tempString)
                
            }
            
        })
        
        
        
        self.MyCollection.reloadData()
        
        indicator.stopAnimating()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "eachImage" {
            let OneImageViewController = segue.destination as! OneImageViewController
            
            let indexPaths : NSArray = self.MyCollection.indexPathsForSelectedItems! as NSArray
            let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
            
            OneImageViewController.url = images[indexPath.row]
            OneImageViewController.key = keys[indexPath.row]
            
        }
        
    }
    
    
}
