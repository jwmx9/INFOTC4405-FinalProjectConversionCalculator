//
//  CalculatorViewController.swift
//  ConversionCalculatorFinalProject
//
//  Created by John Williams III on 5/7/19.
//  Copyright © 2019 John Williams III. All rights reserved.
//

import UIKit

struct Converter {
    let label: String
    let inputUnit: String
    let outputUnit: String
}

class CalculatorViewController: UIViewController {

    @IBOutlet weak var OutputDisplay: UITextField!
    
    @IBOutlet weak var InputDisplay: UITextField!
    
    var convert = [Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"),
                   Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
                   Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
                   Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi")]
    
    var inputVal: Double = 0
    var inputInt: Int = 0
    var outputVal: Double = 0
    var decimalCheck: Bool = false
    var decimalLength: Double = 0
    var zeroPushed: Int = 0
    
    var curConverter: Converter = Converter(label:"fahrenheit to celcius", inputUnit:" °F", outputUnit:" °C")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        curConverter = convert[0]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //Functions for conversion equations
    func fahrenheitToCelcius(_ input: Double) -> Double {
        return (input * 5/9) - 32
    }
    
    func celciusToFahrenheit(_ input: Double) -> Double {
        return (input * 9/5) + 32
    }
    
    func milesToKilometers(_ input: Double) -> Double {
        return input * 1.609344
    }
    
    func kilometersToMiles(_ input: Double) -> Double {
        return input / 1.609344
    }
    
    //Calls required conversion function based on user selection
    func calculateOutput(_ input: Double) -> Double {
        switch curConverter.label {
        case convert[0].label:
            return fahrenheitToCelcius(inputVal)
        case convert[1].label:
            return celciusToFahrenheit(inputVal)
        case convert[2].label:
            return milesToKilometers(inputVal)
        case convert[3].label:
            return kilometersToMiles(input)
        default:
            return input
        }
    }
    
    //Sets the text in the text fields
    func setText() {
        if (decimalCheck){
            InputDisplay.text = "\(inputVal) \(curConverter.inputUnit)"
            outputVal = calculateOutput(inputVal)
            OutputDisplay.text = "\(outputVal) \(curConverter.outputUnit)"
        }else {
            inputInt = Int(inputVal)
            InputDisplay.text = "\(inputInt) \(curConverter.inputUnit)"
            outputVal = calculateOutput(inputVal)
            OutputDisplay.text = "\(outputVal) \(curConverter.outputUnit)"
        }
    }
    
    //Calls an action sheet for the user to make a selection after the converter button is pressed
    @IBAction func ConverterButton(_ sender: Any) {
        let alert = UIAlertController(title: "choose converter", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: convert[0].label, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.InputDisplay.text = "\(self.inputVal) \(self.convert[0].inputUnit)"
            self.OutputDisplay.text = "\(self.fahrenheitToCelcius(self.inputVal)) \(self.convert[0].outputUnit)"
            self.curConverter = self.convert[0]
        }))
        alert.addAction(UIAlertAction(title: convert[1].label, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.InputDisplay.text = "\(self.inputVal) \(self.convert[1].inputUnit)"
            self.OutputDisplay.text = "\(self.celciusToFahrenheit(self.inputVal)) \(self.convert[1].outputUnit)"
            self.curConverter = self.convert[1]
            
        }))
        alert.addAction(UIAlertAction(title: convert[2].label, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.InputDisplay.text = "\(self.inputVal) \(self.convert[2].inputUnit)"
            self.OutputDisplay.text = "\(self.milesToKilometers(self.inputVal)) \(self.convert[2].outputUnit)"
            self.curConverter = self.convert[2]
            
        }))
        alert.addAction(UIAlertAction(title: convert[3].label, style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.InputDisplay.text = "\(self.inputVal) \(self.convert[3].inputUnit)"
            self.OutputDisplay.text = "\(self.kilometersToMiles(self.inputVal)) \(self.convert[3].outputUnit)"
            self.curConverter = self.convert[3]
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Clears the text fields when the clear button is selected
    @IBAction func ClearButton(_ sender: Any) {
        inputVal = 0
        InputDisplay.text = "\(curConverter.inputUnit)"
        OutputDisplay.text = "\(curConverter.outputUnit)"
        decimalCheck = false
    }
    
    @IBAction func negButton(_ sender: UIButton) {
        if (decimalCheck){
            inputVal = -inputVal
            InputDisplay.text = "\(inputVal) \(curConverter.inputUnit)"
            outputVal = calculateOutput(inputVal)
            OutputDisplay.text = "\(outputVal) \(curConverter.outputUnit)"
        } else {
            inputVal = -inputVal
            setText()
        }
    }
    
    @IBAction func periodButton(_ sender: UIButton) {
        if (!(decimalCheck)){
            InputDisplay.text = "\(inputInt). \(curConverter.inputUnit)"
            outputVal = calculateOutput(inputVal)
            OutputDisplay.text = "\(outputVal) \(curConverter.outputUnit)"
            decimalCheck = true
        }
    }
    
    
    @IBAction func zeroButton(_ sender: UIButton) {
        if (decimalCheck){
            decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
            InputDisplay.text = "\(inputVal)0 \(curConverter.inputUnit)"
            outputVal = calculateOutput(inputVal)
            OutputDisplay.text = "\(outputVal) \(curConverter.outputUnit)"
            zeroPushed += 1
        } else {
            inputVal = (inputVal * 10)
            setText()
        }
    }
    
    
    @IBAction func oneButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.1
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (1 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 1
            setText()
        }
    }
    
    @IBAction func twoButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt) && zeroPushed == 0) {
                inputVal += 0.2
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (2 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 2
            setText()
        }
    }
    
    @IBAction func threeButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.3
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (3 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 3
            setText()
        }
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.4
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (4 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 4
            setText()
            
        }
    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.5
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (5 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 5
            setText()
            
        }
    }
    
    @IBAction func sixButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.6
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (6 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 6
            setText()
        }
    }
    
    @IBAction func sevenButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.7
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (7 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 7
            setText()
        }
    }
    
    @IBAction func eightButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.8
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (8 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 8
            setText()
        }
    }
    
    @IBAction func nineButton(_ sender: UIButton) {
        if (decimalCheck){
            if (inputVal == Double(inputInt)) {
                inputVal += 0.9
                setText()
                zeroPushed = 0
            } else {
                decimalLength = Double(inputVal.description.count - inputInt.description.count + zeroPushed)
                inputVal += (9 / pow(10, decimalLength))
                setText()
                zeroPushed = 0
            }
        } else {
            inputVal = (inputVal * 10) + 9
            setText()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
