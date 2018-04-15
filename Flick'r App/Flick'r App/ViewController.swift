//
//  ViewController.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/11/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    let queryService = QueryService()
    
    //data showing the number of pages,perpage,total
    //var currentSetPhotos : Photos?
    
    //array storing photo objects
    var photoImageList: [Photo] = []
    
    //cache that stores images as they are displayed
    let imageCache = NSCache<NSString, AnyObject>()
    
    var reach = Reachability()
    //start at page 1
    var pageNo : Int = 1
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //using reachability class to check for connection
        if reach.isConnectedToNetwork() == false {
            buildAlert()
        }
        
        
        
        //conform to the collectionview's delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
        
        queryService.retrievePhotos(pageNo: pageNo) {
            results, error, queryInfo in
            
            if let results = results {
                print("is something working?")
                self.photoImageList = results
                print(self.photoImageList.count)

               self.reloadTheData()
            }
        }
  
  
    }
    
    //build network connectivity checking alert
    //alerts user with no connectivity
    func buildAlert() {
        let alertControl = UIAlertController(
            title: "Connection!",
            message: "You have no connectivity.",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.destructive)
        let confirmAction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default)
        
        alertControl.addAction(confirmAction)
        alertControl.addAction(cancelAction)
        
        present(alertControl, animated: true, completion : nil)
        
    }
    //reload collection view data
    func reloadTheData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
 
    
    override func viewDidDisappear(_ animated: Bool) {
        //reset the UserDefaults for key: pagination to 1
        
    }
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
