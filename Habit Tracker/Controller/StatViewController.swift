//
//  StatViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/16/20.
//

import SwiftUI

let complimentaryBlue = UIColor().complimentaryBlue()

struct SecondView: View {
	
	@State var pickerSelectedItem = 0
	
	@State var dataPoints: [[CGFloat]] = [
		[50, 100, 150],
		[100, 50, 80],
		[20, 40, 60],
	]
	
	let customBlue = UIColor().customBlue()
	
	var body: some View {
		ZStack {
//			Color(customBlue)
//				.edgesIgnoringSafeArea(.all)
			VStack {
				Text("Deno Belives In You!")
					.font(.system(size: 36))
					.foregroundColor(Color(complimentaryBlue))
					.fontWeight(.bold)
			
				
				Picker(selection: $pickerSelectedItem, label: Text("")) {
					Text("Week").tag(0)
					Text("Month").tag(1)
					Text("Year").tag(2)
				}.pickerStyle(SegmentedPickerStyle())
				.padding(.horizontal, 24)
				
				HStack (spacing: 5) {
						BarView(value: dataPoints[pickerSelectedItem][0])
						BarView(value: dataPoints[pickerSelectedItem][1])
						BarView(value: dataPoints[pickerSelectedItem][0])
						BarView(value: dataPoints[pickerSelectedItem][2])
						BarView(value: dataPoints[pickerSelectedItem][1])
						BarView(value: dataPoints[pickerSelectedItem][0])
						BarView(value: dataPoints[pickerSelectedItem][2])
					}
				}.padding(.top, 24)
				.animation(.default)
			}
		}
	}

struct BarView: View {
	
	var value: CGFloat
	
	var body: some View {
		VStack {
			ZStack (alignment:.bottom) {
				Capsule().frame(width: 30, height: 200)
					.foregroundColor(.gray)
				Capsule().frame(width: 30, height: value)
					.foregroundColor(Color(complimentaryBlue))
			}
			Text("Mo").padding(.top, 8)
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
