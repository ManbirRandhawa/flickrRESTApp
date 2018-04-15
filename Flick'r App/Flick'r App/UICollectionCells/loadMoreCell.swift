//
//  loadMoreCell.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/11/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import UIKit
//protocol to respond to the load button presed
protocol loadCellDelegate {
    func loadButtonPressed(at index: IndexPath)
}

class loadMoreCell: UICollectionViewCell {
    var delegate : loadCellDelegate!
    
    //indexpath of the item in collection view
    var indexPath: IndexPath!
    
    
    let queryService = QueryService()
    
    //load button
    @IBOutlet weak var loadButton: UIButton!
    
    @IBAction func loadMore(_ sender: UIButton) {
        //load button pressed at this index path
        self.delegate?.loadButtonPressed(at: indexPath)
       
        
    }
    
}
