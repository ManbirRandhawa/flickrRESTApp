//
//  QueryService.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/11/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import Foundation
class QueryService {
    //setup
    let defaultTask = URLSession(configuration: .default)
    
    var fetchTask : URLSessionDataTask?
    
    //Given API key
    let apiKey = "7b85e389607020e3b5a12c5a40e260db"
    //single photo object
    var photos : Photos?
    //array holding photo objects
    var photoList : [Photo] = []
    
    //for easier parsing purposes
    typealias JSONDict = [String:Any]
    //for returning the data in the viewController
    typealias QueryResult = ([Photo]?, String, Photos?) -> ()
    
    var errorMessage = ""
    
    var userDefaults = UserDefaults.standard
    
    func retrievePhotos(pageNo : Int, completion: @escaping QueryResult) {
        
        var responsed : JSONDict?
        
        //in current implementation: must change per_page to the number of elements you want fetched per request;
        // TODO: pass along the Photos object that stores the perpage,pages,page,total information
        let photoURL = URL(string:"https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(apiKey)&per_page=1000&page=\(pageNo)&format=json&nojsoncallback=1")
            
        
        guard let flickrURL = photoURL else {
            print("incorrect URL")
            return
        }
        
        fetchTask = defaultTask.dataTask(with: flickrURL, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                print("ERROR! \(error.localizedDescription)")
                
                //passing this error to viewcontroller through closure
                self.errorMessage = self.errorMessage + error.localizedDescription + " in data task area "
            } else if let data = data {
                
                //data successfully returned
                //decode the data into json
                do {
                    responsed = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDict
  
                } catch {
                    print(error.localizedDescription + " error" )
                }
                //parse json
                if let array = responsed!["photos"] as? JSONDict,
                    let page = array["page"] as? Int,
                    let pages = array["pages"] as? Int,
                    let perpage = array["perpage"] as? Int,
                    let total = array["total"] as? Int,
                    let photo = array["photo"] as? [[String: Any]]{
                    
                    for item in photo {
                            if let id = item["id"] as? String{
                                let secret = item["secret"] as? String
                                let server = item["server"] as? String
                                let farm = item["farm"] as? Int
                                let title = item["title"] as? String
                                let img = item["img"] as? String
                                //append successfully parsed new photo object to array
                                self.photoList.append(Photo(id: id, secret: secret, server: server, farm: farm, title: title, img: img))
                            } else {
                                print("problem parsing photo's attributes")
                        }
                       
                    }
                    self.photos = Photos(page: page, pages: pages, perpage: perpage, total: total)

                    DispatchQueue.main.async {
                        print("passing new photo objects to the viewcontroller")
                        completion(self.photoList, self.errorMessage, self.photos)
                    }
                    
                } else {
                    print("problem parsing JSON")
                }
            }
        })
        //begin the task
        fetchTask?.resume()
       
    }

}
