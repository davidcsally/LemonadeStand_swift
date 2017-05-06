//
//  LemonadeStandModel.swift
//  PA13_PickersAndAlerts
//
//  Created by David Sally on 4/10/17.
//  Copyright © 2017 David Sally. All rights reserved.
//

import UIKit

class LemonadeStandModel {
	
	// MARK: - Properties
	private var drinkFlavors: [String] = ["Lemonade"]
	private var drinkSizes: [String] = ["Small", "Medium", "Large", "Gargantuan"]
	private var orderLog: [String] = []
	
	static let sharedInstance = LemonadeStandModel()
	
	// MARK: - Funcs [Getters]
	
	/// get the number of flavors available
	func numberOfFlavors() -> Int {
		if drinkFlavors.isEmpty {
			return 0
		} else {
			return drinkFlavors.count
		}
	}
	
	/// get the number of sizes available
	func numberOfSizes() -> Int {
		if drinkSizes.isEmpty {
			return 0
		} else {
			return drinkSizes.count
		}
	}
	
	/// return the total number of orders
	func numberOfOrders() -> Int {
		return orderLog.count
	}
	
	/// get the name of a flavor from a given index
	func returnFlavor(index: Int) -> String {
		if drinkFlavors.isEmpty {
			return "ERROR"
		} else {
			return drinkFlavors[index]
		}
	}
	
	/// get the name of a drink size from a given index
	func returnSize(index: Int) -> String {
		return drinkSizes[index]
	}
	
	/// return a string from the order log data
	func returnOrderLog() -> String {
		var orderLogString:String = ""
		
		orderLogString.append("ORDER LOG:\n")
		
		for i in (0..<orderLog.count).reversed() {
			var data = orderLog[i].components(separatedBy: "*")
			orderLogString.append("Order #\(i + 1): \(data[0]) \(data[1])\n")
		}
		return orderLogString
	}
	
	/// return data that is used to construct table cells
	func returnTableLog(index:Int) -> (flavor:String, size:String) {
		
		let myIndex = abs(orderLog.count - index) - 1
		
		print("index: \(index); absolute value: \(myIndex)")
		
		var data = orderLog[myIndex].components(separatedBy: "*")
		return (data[0], data[1])
	}
	
	// MARK: - Funcs [Adding]
	/// Adding
	
	/// add a new flavor to the model
	func addFlavor(newFlavor: String) -> Bool {
		// don't add duplicate flavors
		for flavor in 0..<drinkFlavors.count {
			if drinkFlavors[flavor] == newFlavor {
				print("already exists: \(drinkFlavors[flavor]) at: \(flavor)")
				return false
			}
		}
		
		drinkFlavors.append(newFlavor)
		return true
	}

	/// record a new order
	func recordOrder(flavor: Int, size: Int) {
		orderLog.append("\(drinkFlavors[flavor]) *\(drinkSizes[size])")
	}


	// MARK: - Funcs [Removing]
	/// Deleting
	
	/// remove a flavor from the model
	func removeFlavor(index: Int) {
		print("flavorToRemove: \(drinkFlavors[index])")
		drinkFlavors.remove(at: index)
	}
}
