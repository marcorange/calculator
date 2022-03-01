//
//  ViewController.swift
//  CalculatorHW03
//
//  Created by disco on 24.02.2022.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var calculatorWindow: UILabel!

	private var userInput = ""
	private var operation = ""
	private var resultInUsage = false
	private var isDecimal = false
	
	override func viewDidLoad() {
		super.viewDidLoad()

		calculatorWindow.text = "0"
	}
	
	func monitorExpression(_ enteredNumber: String) {
		if enteredNumber == "0" {
			guard !userInput.isEmpty && !resultInUsage else {
				return
			}
		}
		if resultInUsage && operation.isEmpty {
			userInput = ""
			resultInUsage = false
		}
		userInput += enteredNumber
		calculatorWindow.text = userInput
	}
	
	func enterOperation(_ operationToSet: String) {
		guard !userInput.isEmpty && operation.isEmpty
		else {
			return
		}
		if userInput.hasSuffix(".") {
			userInput += "0"
		}
		operation = operationToSet
		monitorExpression(operationToSet)
		isDecimal = false
	}
	
	@IBAction func digits(_ sender: UIButton) {
		monitorExpression("\(sender.tag)")
	}
	
	// MARK: - Operations
	
	@IBAction func equality() {
		guard !userInput.isEmpty && !operation.isEmpty else {
			return
		}
		if userInput.hasSuffix(".") {
			userInput += "0"
		}
		if userInput.hasSuffix(operation) && operation != "*0.01" {
			userInput += userInput
			userInput.removeLast()
		}
		let mathExpression = NSExpression(format: userInput)
		guard let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double else {
			return
		}
		calculatorWindow.text = String(mathValue)
		userInput = String(mathValue)
		resultInUsage = true
		operation = ""
		isDecimal = false
	}
	
	@IBAction func erase(_ sender: UIButton) {
		userInput = ""
		calculatorWindow.text = "0"
		isDecimal = false
	}
	
	@IBAction func changeSign(_ sender: Any) {
		guard operation.isEmpty && !userInput.isEmpty else {
			return
		}
		if userInput.starts(with: "-") {
			userInput.removeFirst()
		}
		else {
			userInput = "-" + userInput
		}
		calculatorWindow.text = userInput
	}

	@IBAction func convertToPercents(_ sender: UIButton) {
		enterOperation("*0.01")
		guard operation == "*0.01" else {
			return
		}
		equality()
	}
	
	@IBAction func division(_ sender: Any) {
		enterOperation("/")
	}
	
	@IBAction func multiplication(_ sender: Any) {
		enterOperation("*")
	}
	
	@IBAction func subtraction(_ sender: UIButton) {
		enterOperation("-")
	}
	
	@IBAction func addition(_ sender: Any) {
		enterOperation("+")
	}
	
	@IBAction func decimalSeparator(_ sender: Any) {
		guard !isDecimal else {
			return
		}
		if userInput.isEmpty {
			monitorExpression("0.")
		}
		else {
			monitorExpression(".")
		}
		isDecimal = true
	}
}

