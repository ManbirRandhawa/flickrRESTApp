//
//  VC + CollectionViewDelegate.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/12/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //provide the collectionview with the number of items
    //added + 1 for the load more cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoImageList.count + 1
    }
    ///provide the type of cell and data for the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item < photoImageList.count else {
            
            //if current page number is less than 50 (20 items per page, 50 pages = 1000)
            //display the load more button
            if pageNo < 1 {
                let loadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadCell", for: indexPath) as! loadMoreCell
                loadCell.delegate = self
                loadCell.indexPath = indexPath
                
                return loadCell
            }
            //else we are at the end of our pages, display a load cell with no button
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadCell", for: indexPath) as! loadMoreCell
            emptyCell.loadButton.isHidden = true
            
            return emptyCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customImageCell", for: indexPath) as! CustomCollectionCell
        
        //pass the cell its photo object
        cell.photo = photoImageList[indexPath.item]
        //call on the cell to conduct its setup
        cell.setUpImage()
        //ensure the image fits the cell
        cell.thumbnailView.clipsToBounds = true
        cell.thumbnailView.contentMode = .scaleToFill
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        return cell;
        
        
    }
}
