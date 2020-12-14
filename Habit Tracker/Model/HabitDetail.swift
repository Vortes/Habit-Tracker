//
//  HabitChild.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/14/20.
//

import Foundation
import RealmSwift

class HabitDetail: Object {
	@objc dynamic var progress: Float = 0.0
	
	var parentHabit = LinkingObjects(fromType: Habit.self, property: "habitDetails")
}
