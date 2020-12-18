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
	
	let yvalues: [BarChartDataEntry] = [
		BarChartDataEntry(x: 0.0, y: 6.0),
		BarChartDataEntry(x: 1.0, y: 8.0),
		BarChartDataEntry(x: 2.0, y: 5.0),
		BarChartDataEntry(x: 3.0, y: 6.0),
		BarChartDataEntry(x: 4.0, y: 8.0),
		BarChartDataEntry(x: 5.0, y: 5.0),
		BarChartDataEntry(x: 6.0, y: 6.0),
		BarChartDataEntry(x: 7.0, y: 8.0),
		BarChartDataEntry(x: 8.0, y: 5.0),
		BarChartDataEntry(x: 9.0, y: 6.0),
		BarChartDataEntry(x: 10.0, y: 8.0),
		BarChartDataEntry(x: 11.0, y: 5.0),
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
		set1.colors = ChartColorTemplates.pastel()
		
		let data = BarChartData(dataSet: set1)
		barChartView.xAxis.labelPosition = .bottom
		barChartView.rightAxis.enabled = false
		barChartView.data = data
	}
	
}
