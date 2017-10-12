    //
    //  HomeTableViewController.swift
    //  Homework2
    //
    //  Created by Bonageri, Venkatesh on 10/7/17.
    //  Copyright © 2017 Shehab, Mohamed. All rights reserved.
    //

    import UIKit
    import Alamofire
    import SDWebImage

    class HomeTableViewController: UITableViewController {

         var categories : [String:Int] = [String:Int]()
        var appsData : [String:[Apps]] = [String:[Apps]]()
        
        var categoriesArray : [String] = [String]()
        
        
        func getMyJSONdata() {
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
             
                Alamofire.request("http://dev.theappsdr.com/apis/summer_2016_ios/data.json").responseData { (resData) -> Void in
                
                    
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: resData.result.value!) as! [String:AnyObject]
                        let appsArray = parsedData["feed"] as! [[String:AnyObject]]
                        
                        for item in appsArray {
                            
                            let title = (item["name"] as! [String:AnyObject])["label"]  as? String
                            let devname = (item["artist"] as! [String:AnyObject])["label"]  as? String
                            let rdate = (item["releaseDate"] as! [String:AnyObject])["label"]  as? String
                            let price = (item["price"] as! [String:AnyObject])["amount"]  as? Double
                            let square = ((item["squareImage"] as! [[String:AnyObject]])[0]  )["label"] as? String
                            
                            var other = ""
                            
                            if (item["otherImage"] as? [[String:AnyObject]]) != nil  {
                                
                                other = (((item["otherImage"] as! [[String:AnyObject]])[0] )["label"] as? String)!
                                
                            }
                            
                            
                            
                            var summary = ""
                            
                            if (item["summary"] as? [String:AnyObject]) != nil  {
                                
                                summary = ((item["summary"] as! [String:AnyObject])["label"]  as? String)!
                                
                            }
                            
                            
                            
                            let cat = ((item["category"] as! [String:AnyObject])["attributes"] as! [String: AnyObject])["term"] as? String
                            
                            let tempApp = Apps(Title: title!,DevName: devname!,Rdate: rdate!,Price: price!,squareImage: square!,otherImage: other,summary: summary,category: cat!)
        
                            
                            
                            if let val = self?.categories[cat!] {
                                self?.categories[cat!] = val + 1
                                
                                var tempArrApp : [Apps] = self!.appsData[cat!]!
                                tempArrApp.append(tempApp)
                                self?.appsData[cat!] = tempArrApp
                                
                            }
                            else{
                                
                                self?.categories[cat!] =  1
                                
                                var tempArrApp : [Apps] = [Apps]()
                                tempArrApp.append(tempApp)
                                self?.appsData[cat!] = tempArrApp
                                
                            }
                        }
                        
                        self?.fillcatArray()
                        
                        self?.tableView.reloadData()
                        
                    } catch let error as NSError {
                        print(error)
                    }
                    
                }
                
            }
            
        }
        
        func fillcatArray()  {
            categoriesArray = Array(categories.keys)
            
            categoriesArray = categoriesArray.sorted()
            
            /*
             for var i in (0..<categoriesArray.count) {
             appsData[categoriesArray[i]] = appsData[categoriesArray[i]]?.sorted(by: { $0.Title < $1.Title })
             }
             */
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()

            getMyJSONdata()

        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return categories.count
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            
            return categories[categoriesArray[section]]!
            
            
        }
        
        

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           

            // Configure the cell...
            
            let tempCat = categoriesArray[indexPath[0]]
            let tempArrAppData : [Apps] = appsData[tempCat]!
            
            let tempApp : Apps = tempArrAppData[indexPath[1]]
            
            if(tempApp.summary != "")
            {
                let cell = Bundle.main.loadNibNamed("TableViewCellWithSummary", owner: self , options: nil)?.first as! TableViewCellWithSummary
                
                cell.Stitle.text = tempApp.Title
                
                
                cell.SdevName.text = tempApp.DevName
                cell.Srdate.text = tempApp.Rdate
                
                cell.Sprice.text = "$ " + String(format: "%.2f", tempApp.Price)
                cell.Ssummary.text = tempApp.summary
                
                

                cell.Ssquare.sd_setImage(with: URL(string: tempApp.squareImage), placeholderImage: UIImage(named: "placeholder.png"))
                
                return cell
            }
            else if(tempApp.otherImage != "")
            {
                let cell = Bundle.main.loadNibNamed("TableViewCellOtherImage", owner: self , options: nil)?.first as! TableViewCellOtherImage
                
                cell.Otitle.text = tempApp.Title
                cell.Odevname.text = tempApp.DevName
                cell.Ordate.text = tempApp.Rdate
                
                
                
                cell.Oprice.text = "$ " + String(format: "%.2f", tempApp.Price)
                
                cell.Osquare.sd_setImage(with: URL(string: tempApp.squareImage), placeholderImage: UIImage(named: "placeholder.png"))
                
                cell.Ootherimage.sd_setImage(with: URL(string: tempApp.otherImage), placeholderImage: UIImage(named: "placeholder.png"))
                
                return cell
            }
            else{
                
                let cell = Bundle.main.loadNibNamed("TableViewCellWithout", owner: self , options: nil)?.first as! TableViewCellWithout
                
                cell.Wtitle.text = tempApp.Title
                cell.WdevName.text = tempApp.DevName
                cell.Wrdate.text = tempApp.Rdate
                
                cell.Wprice.text = "$" + String(format: "%.2f", tempApp.Price)
                
                cell.WsquareImage.sd_setImage(with: URL(string: tempApp.squareImage), placeholderImage: UIImage(named: "placeholder.png"))
                
                
                
                return cell
            }


        }
        
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            
            return categoriesArray[section]
            
        }
     

    }
