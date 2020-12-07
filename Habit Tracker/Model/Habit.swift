//
//  Product.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/6/20.
//

import UIKit

class Habit {
    var title: String
    var detail: String
//    var progress: Progress
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
//        self.progress = progress
    }
    
    func updateDetail() -> Int {
        return Int(detail)! - 1
    }
    
}
