//
//  StatViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/16/20.
//

import SwiftUI

struct SecondView: View {
  var body: some View {
	  VStack {
		  Text("Second View").font(.system(size: 36))
		  Text("Loaded by SecondView").font(.system(size: 14))
	  }
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
