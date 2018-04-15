//
//  Photos.swift
//  Flick'r App
//
//  Created by Manbir randhawa on 4/11/18.
//  Copyright © 2018 Manbir randhawa. All rights reserved.
//

import Foundation

class Photos {
    
    let page : Int
    let pages : Int
    let perpage : Int
    let total : Int
   
    init(page: Int, pages: Int, perpage : Int, total : Int) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
        
    }
}
