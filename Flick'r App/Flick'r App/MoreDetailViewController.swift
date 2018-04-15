//
//  MoreDetailViewController.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/12/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import UIKit

class MoreDetailViewController: UIViewController {
    //image view to display full sized image
    @IBOutlet weak var fullImageView: UIImageView!
    
    //variables for the segue to push data to for displaying
    weak var imageDat : UIImage!
    var titleText : String!
    
    //text label to display the image's title if it has one
    @IBOutlet weak var titleLabel: UILabel!
    
    //set up image and label
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fullImageView.image = imageDat
        fullImageView.contentMode = .scaleAspectFill
        titleLabel.text = titleText
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
