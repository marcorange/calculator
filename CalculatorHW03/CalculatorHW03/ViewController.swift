//
//  ViewController.swift
//  CalculatorHW03
//
//  Created by disco on 24.02.2022.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var calculatorWindow: UILabel!

	var userInput = ""
	var operation = ""
	var resultInUsage: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()

		calculatorWindow.text = "0"
	}

	func monitorExpression(_ enteredNumber: String) {
		if resultInUsage && operation.isEmpty {
			userInput = ""
			resultInUsage = false
		}
		userInput += enteredNumber
		calculatorWindow.text = userInput
	}
	
	func enterOperation(_ operationToSet: String) {
		if userInput.isEmpty {
			return
		}
		if !operation.isEmpty {
			return
		}
		else {
			operation = operationToSet
			monitorExpression(operationToSet)
		}
	}
	
	@IBAction func equality() {
		if userInput.isEmpty || userInput.hasSuffix("."){
			return
		}
		if userInput.hasSuffix(operation) && operation != "*0.01" {
			userInput += userInput
			userInput.removeLast()
		}
		let mathExpression = NSExpression(format: userInput)
		if let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double {
			calculatorWindow.text = String(mathValue)
			userInput = String(mathValue)
			resultInUsage = true
		}
		operation = ""
	}
	
// OPERATIONS
	@IBAction func erase(_ sender: UIButton) {
		userInput = ""
		calculatorWindow.text = "0"
	}
	
	@IBAction func changeSign(_ sender: Any) {
		if !operation.isEmpty || userInput.isEmpty {
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
		if userInput.contains(".") {
			return
		}
		if userInput.isEmpty {
			monitorExpression("0.")
		}
		else {
			monitorExpression(".")
		}
	}
	
// NUMBERS
	@IBAction func seven(_ sender: Any) {
		monitorExpression("7")
	}
	
	@IBAction func eight(_ sender: Any) {
		monitorExpression("8")
	}
	
	@IBAction func nine(_ sender: Any) {
		monitorExpression("9")
	}

	@IBAction func four(_ sender: Any) {
		monitorExpression("4")
	}
	
	@IBAction func five(_ sender: Any) {
		monitorExpression("5")
	}
	
	@IBAction func six(_ sender: Any) {
		monitorExpression("6")
	}

	@IBAction func one(_ sender: Any) {
		monitorExpression("1")
	}
	
	@IBAction func two(_ sender: Any) {
		monitorExpression("2")
	}
	
	@IBAction func three(_ sender: Any) {
		monitorExpression("3")
	}

	@IBAction func zero(_ sender: Any) {
		if !userInput.isEmpty {
			monitorExpression("0")
		}
	}

}

