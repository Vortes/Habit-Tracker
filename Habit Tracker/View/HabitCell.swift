//
//  HabitCell.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/19/20.
//

import UIKit
import SwipeCellKit

class HabitCell: SwipeTableViewCell {

	@IBOutlet weak var habitView: UIView!
	@IBOutlet weak var habitXibName: UILabel!
	@IBOutlet weak var habitProgress: UIProgressView!
	@IBOutlet weak var slash: UILabel!
	
	@IBOutlet weak var userProgress: UILabel!
	@IBOutlet weak var totalProgress: UILabel!
	
	@IBOutlet weak var progressBarXib: UIProgressView!
	
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		habitXibName.font = UIFont(name:"Helvetica Neue Bold",size:22)
		userProgress.font = UIFont(name: "Helvetica Neue", size: 22)
		totalProgress.font = UIFont(name: "Helvetica Neue", size: 22)
		slash.font = UIFont(name: "Helvetica Neue", size: 22)
    }
	
	var habit: Habit? {
		didSet {
			self.updateUI()
		}
	}
	
	func updateUI() {
		habitXibName?.text = habit?.title
		totalProgress?.text = habit?.totalCount
		progressBarXib?.progress = habit?.progress ?? 0.0
		userProgress?.text = String(habit?.userCount ?? 0)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
