//
//  StatViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/16/20.
//

import SwiftUI

let complimentaryBlue = UIColor().complimentaryBlue()

struct SecondView: View {
	
	let customBlue = UIColor().customBlue()
	
	var body: some View {
		
		Text("Hello")
		
	}
}

class StatViewController: UIHostingController<SecondView> {

	required init?(coder: NSCoder) {
		super.init(coder: coder,rootView: SecondView());
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
