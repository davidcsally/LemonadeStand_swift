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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationItem.title = "Order Log"
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myModel.numberOfOrders()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
		
		let flavor = myModel.returnTableLog(index: row).flavor
		let size = myModel.returnTableLog(index: row).size
		let orderNum = abs(myModel.numberOfOrders() - row)
		
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! OrderLogCellTableViewCell
		
		cell.drinkLabel.text = flavor
		cell.sizeLabel.text = size
		cell.orderNum.text = "Order: \(orderNum)"
		
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
