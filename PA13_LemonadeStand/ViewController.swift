//
//  ViewController.swift
//  PA13_PickersAndAlerts
//
//  Created by David Sally on 4/10/17.
//  Copyright © 2017 David Sally. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

	/// ****************
	/// ** Properties **
	/// ****************
	// MARK: - Properties
	var lemonadeStand = LemonadeStandModel.sharedInstance
	var buttonCollection = [UIButton!]()
	
	
	/// ****************
	/// *** Outlets ****
	/// ****************
	// MARK: - Outlets
	
	@IBOutlet var drinkPicker: UIPickerView!
	@IBOutlet var flavorTextField: UITextField!
	@IBOutlet var orderLogOutlet: UITextView!

	@IBOutlet var addFlavorOutlet: UIButton!
	@IBOutlet var removeButtonOutlet: UIButton!
	@IBOutlet var recordOrderOutlet: UIButton!
	@IBOutlet var showTableOutlet: UIButton!
	
	
	/// ****************
	/// ***** View *****
	/// ****************
	// MARK: - View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		/// button formatting
		buttonCollection.append(addFlavorOutlet)
		buttonCollection.append(removeButtonOutlet)
		buttonCollection.append(recordOrderOutlet)
		buttonCollection.append(showTableOutlet)
		
		for i in 0..<buttonCollection.count {
			let cornerRadius : CGFloat = 7.0
			buttonCollection[i].layer.borderWidth = 1
			buttonCollection[i].layer.borderColor = UIColor.black.cgColor
			buttonCollection[i]?.layer.cornerRadius = cornerRadius
		}
		
		/// picker formatting
		drinkPicker.layer.borderColor = UIColor.black.cgColor
		drinkPicker.layer.borderWidth = 1
		
		/// text field formatting
		flavorTextField.layer.borderColor = UIColor.black.cgColor
		flavorTextField.layer.borderWidth = 1
		
		/// text view formatting
		orderLogOutlet.text = ""
		orderLogOutlet.layer.borderColor = UIColor.black.cgColor
		orderLogOutlet.layer.borderWidth = 1
	}
	
	
	/// ****************
	/// **** Actions ***
	/// ****************
	// MARK: - Actions

	/// hide keyboard if background is tapped
	@IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
		print("Background tapped")
		self.view.endEditing(true)
		resignFirstResponder()
	}
	
	/// add flavor from text field
	@IBAction func addFlavor(_ sender: UIButton) {
		
		/// check if text field is empty
		if (flavorTextField.text?.isEmpty)! {
			presentWarningAlert(alertMessage: "Flavor is empty!")
			return
		}
		
		// if text is present, attempt to add the new flavor
		let flavor = flavorTextField.text
		let flavorIsNew = lemonadeStand.addFlavor(newFlavor: flavor!)
		
		/// if duplicate, warn user and end
		if !(flavorIsNew) {
			presentWarningAlert(alertMessage: "Flavor already exists!")
			return
		}
		
		drinkPicker.reloadAllComponents()
	}

	/// remove the selected flavor from the picker, if possible
	@IBAction func removeFlavor(_ sender: UIButton) {
		
		let flavorToRemove = drinkPicker.selectedRow(inComponent: 0)
		let flavor = lemonadeStand.returnFlavor(index: flavorToRemove)
		
		print("flavor: \(flavor)")

		/// check if picker component is empty
		if flavor == "ERROR" {
			presentWarningAlert(alertMessage: "Flavor Picker is empty")
			return
		}
		
		/// UI Alert
		let alert = UIAlertController(title: "Delete Flavor", message: "Really remove: \(flavor)?", preferredStyle: .actionSheet)
		
		alert.addAction(UIAlertAction(title: "Nope", style: .cancel, handler: nil))
		
		alert.addAction(UIAlertAction(title: "Yes, remove it!", style: .destructive, handler: { (alert) in
		
		/// remove the flavor and refresh the picker
		self.lemonadeStand.removeFlavor(index: flavorToRemove)
		self.drinkPicker.reloadAllComponents()
		}))
		
		/// show the alert
		present(alert, animated: true, completion: nil)
		
	}
	
	/// record selected components and update order log
	@IBAction func recordOrder(_ sender: UIButton) {
		
		let flavor = drinkPicker.selectedRow(inComponent: 0)
		
		/// check if picker component is empty
		if lemonadeStand.returnFlavor(index: 0) == "ERROR" {
			presentWarningAlert(alertMessage: "Flavor Picker is empty")
			return
		}
		
		let size = drinkPicker.selectedRow(inComponent: 1)
		
		lemonadeStand.recordOrder(flavor: flavor, size: size)
		updateLogLabel()
	}
	
	
	/// ****************
	/// *** Delegates **
	/// ****************
	// MARK: - TextField Delegates
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		/// check if text field is empty
		if !((flavorTextField.text?.isEmpty)!) {
			
			let flavor = flavorTextField.text
			let flavorIsNew = lemonadeStand.addFlavor(newFlavor: flavor!)
			
			/// if flavor is duplicate, warn user and end
			if !(flavorIsNew) {
				presentWarningAlert(alertMessage: "Flavor already exists!")
				textField.endEditing(true)
				textField.text = ""
				return true
			}
			
			/// add the flavor
			textField.endEditing(true)
			drinkPicker.reloadAllComponents()
			textField.text = ""
			return true
		}
		
		/// dismiss keyboard after pressing enter, also clear the text field
		textField.endEditing(true)
		textField.text = ""
		return true
	}
	
	// MARK: - Picker Data  Source
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 2
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		
		switch component {
			case 0:
				return lemonadeStand.numberOfFlavors()
			default:
				return lemonadeStand.numberOfSizes()
		}
		
	}
	
	// MARK: - PickerViewDelagate
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
		/// get name from model and return to picker
		switch component {
			case 0:
				return lemonadeStand.returnFlavor(index: row)
			default:
				return lemonadeStand.returnSize(index: row)
		}
		
	}
	
	/// ****************
	/// **** Funcs *****
	/// ****************
	// MARK: - Funcs
	
	/// change back button title
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		let backItem = UIBarButtonItem()
//		backItem.title = "Back"
//		navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
//	}
	
	/// update order log label
	func updateLogLabel() {
		orderLogOutlet.text = lemonadeStand.returnOrderLog()
	}
	
	/// create and present an error alert message to the user
	func presentWarningAlert(alertMessage:String) {
		let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)

	}

}

