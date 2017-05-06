//
//  OrderLogTableTableViewController.swift
//  PA13_PickersAndAlerts
//
//  Created by David Sally on 4/12/17.
//  Copyright © 2017 David Sally. All rights reserved.
//

import UIKit

class OrderLogTableTableViewController: UITableViewController {
	
	// MARK: - Properties
	var myModel = LemonadeStandModel.sharedInstance
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Order Log"
	}
	
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//        return myModel.returnTableLog(index: )
		return myModel.numberOfOrders()
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
		
		let flavor = myModel.returnTableLog(index: row).flavor
		let size = myModel.returnTableLog(index: row).size
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath)
		
		cell.textLabel?.text = flavor
		cell.detailTextLabel?.text = size
		
		// Configure the cell...
		
		return cell
	}
	
}
