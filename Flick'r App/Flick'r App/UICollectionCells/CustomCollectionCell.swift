//
//  CustomCollectionCell.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/11/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    //imageview to display one single cell
    @IBOutlet weak var thumbnailView: UIImageView!
    
    //fully constructed link to the image for fetching purposes
    var imageDownloadLink : URL?
    var photo : Photo?
    
    //image cache so the view will not constantly refetch data if it doesn't have to
    let imageCache = NSCache<NSString , UIImage>()
    
    //construct the actual image link with the appropriate parameters
    //TODO: use query paramters instead of manual string concatentation
    func setUpLink() {
        var urlConstruct : String = "https://farm\(photo!.farm!).staticflickr.com"
        urlConstruct += "/\(photo!.server!)/"
        urlConstruct += "\(photo!.id!)_"
        urlConstruct += "\(photo!.secret!).jpg"
        
        let url = URL(string : urlConstruct)
        imageDownloadLink = url

    }
    
    func setUpImage() {
        setUpLink()
        //ensure the dowload link is not nil
        if let thumbImg = imageDownloadLink {
            
            //if the image was already fetched earlier, do not re-fetch
            if let cached = imageCache.object(forKey: thumbImg.absoluteString as NSString) {
                self.thumbnailView.image = cached
                
            } else {
                //download image
                URLSession.shared.dataTask(with: thumbImg, completionHandler: {
                    (data, response, error) in
                    //if there is an error, print it
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    DispatchQueue.main.async {
                        //set the data as an UIIMage
                        let image = UIImage(data : data!)
                        //set the image in the image cache
                        self.imageCache.setObject(image!, forKey: thumbImg.absoluteString as NSString)
                        //set image to the image view
                        self.thumbnailView.image = image
                    }
                }).resume()
            }
        }
    }
}

