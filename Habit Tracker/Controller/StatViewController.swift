//
//  StatViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/16/20.
//

import UIKit
import Charts

class StatViewController: UIViewController {
	
	@IBOutlet weak var barChartView: BarChartView!
	open var barWidth = Double(0.85)
	
	let yvalues: [BarChartDataEntry] = [
		BarChartDataEntry(x: 0.0, y: 6.0),
		BarChartDataEntry(x: 1.0, y: 8.0),
		BarChartDataEntry(x: 2.0, y: 5.0),
		BarChartDataEntry(x: 3.0, y: 6.0),
		BarChartDataEntry(x: 4.0, y: 8.0),
		BarChartDataEntry(x: 5.0, y: 5.0),
		BarChartDataEntry(x: 6.0, y: 6.0),
	]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setData()
    }
    
	@IBAction func cancelButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

}

extension StatViewController: ChartViewDelegate {
	
	func setData() {
		let set1 = BarChartDataSet(entries: yvalues, label: "chart")
		
		let data = BarChartData(dataSet: set1)
		data.barWidth = Double(0.55)
		
		let yAxis = barChartView.leftAxis
		let xAxis = barChartView.xAxis
		
		yAxis.labelTextColor = .black
		yAxis.drawAxisLineEnabled = false
		yAxis.drawGridLinesEnabled = false
		xAxis.drawAxisLineEnabled = false
		
		barChartView.xAxis.labelPosition = .bottom
		barChartView.rightAxis.enabled = false
		barChartView.data = data
		barChartView.drawBarShadowEnabled = true
		barChartView.layer.cornerRadius = 10
	}
	
}
