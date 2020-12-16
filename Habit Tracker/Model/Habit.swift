//
//  Product.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/6/20.
//

import UIKit
import RealmSwift

class Habit: Object {
	@objc dynamic var title: String = ""
	@objc dynamic var totalCount: String = ""
	@objc dynamic var userCount: Int =  0
	@objc dynamic var progress: Float = 0.0
	
//	init(title: String, detail: String) {
//		self.title = title
//		self.detail = detail
//	}
	
	let habitDetails = List<HabitDetail>()
	
}
