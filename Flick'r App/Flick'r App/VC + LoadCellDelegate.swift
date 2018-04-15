//
//  VC + LoadCellDelegate.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/12/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import UIKit

extension ViewController: loadCellDelegate {
    func loadButtonPressed(at index: IndexPath) {
  
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        //increment the page number
        pageNo = pageNo + 1
        
        //call queryService with this new page number
        queryService.retrievePhotos(pageNo: pageNo) {
            (result, error, queryInfo) in
            
            guard let result = result else {
                
                print(error.description)
                return
            }
            
            //populate the array
            
            self.photoImageList = result
            
            //call to collectionview data reloading
            self.reloadTheData()
        }
    }
    
    
}

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullImageSegue"{
            let destinationVC = segue.destination as! MoreDetailViewController
            let cell = sender as! CustomCollectionCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            guard let imageData = cell.imageCache.object(forKey: cell.imageDownloadLink?.absoluteString as! NSString) else {
                print("error retrieving image from cache!")
                return
            }
            //print(cell.photo?.title as! String)
            //destinationVC.fullImageView? = imageData as? UIImage
            destinationVC.titleText = cell.photo?.title as! String
            destinationVC.imageDat = imageData
            
        }
    }
}
