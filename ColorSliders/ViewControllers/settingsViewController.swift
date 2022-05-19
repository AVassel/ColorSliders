//
//  ViewController.swift
//  ColorSliders
//
//  Created by Anton Vassel on 31.03.2022.
//

import UIKit



class SettingsViewController: UIViewController {
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var canvasView: UIView!
    
    @IBOutlet weak var doneToolBar: UIToolbar!
    
    var canvasBackgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    var oldColor:Float = 0.0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        self.redTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
        self.greenTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
        self.blueTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
        
        let cicolor = CIColor(color: canvasBackgroundColor ?? .white)
        
        canvasView.layer.cornerRadius = 25
        canvasView.backgroundColor = canvasBackgroundColor
        
        redSlider.value = Float(cicolor.red)
        greenSlider.value = Float(cicolor.green)
        blueSlider.value = Float(cicolor.blue)
        
        updateTextInLabelAndTextField(for: "red")
        updateTextInLabelAndTextField(for: "green")
        updateTextInLabelAndTextField(for: "blue")
    }

    @IBAction func redColorAction() {
        updateTextInLabelAndTextField(for: "red")
        paintCanvas()
    }

    @IBAction func greenColorAction() {
        updateTextInLabelAndTextField(for: "green")
        paintCanvas()
    }
    
    @IBAction func blueColorAction() {
        updateTextInLabelAndTextField(for: "blue")
        paintCanvas()
    }
    
    private func paintCanvas() {
        canvasView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func string(for slider:UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func updateTextInLabelAndTextField(for color: String) {
        switch color {
        case "red":
            redValueLabel.text = string(for: redSlider)
            redTextField.text = redValueLabel.text
        case "green":
            greenValueLabel.text = string(for: greenSlider)
            greenTextField.text = greenValueLabel.text
        default:
            blueValueLabel.text = string(for: blueSlider)
            blueTextField.text = blueValueLabel.text
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNewBackgroundColor(with: canvasView.backgroundColor ?? .blue)
        dismiss(animated: true)
    }
    
    @objc func tapDone() {
        self.view.endEditing(true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        if numberValue >= 0 && numberValue <= 1 {
        switch textField {
        case redTextField: do {
            self.redSlider.value = Float(textField.text ?? "0") ?? 0
            redValueLabel.text = redTextField.text
        }
        case greenTextField: do {
            self.greenSlider.value = Float(textField.text ?? "0") ?? 0
            greenValueLabel.text = greenTextField.text
        }
        default:  do {
            self.blueSlider.value = Float(textField.text ?? "0") ?? 0
            blueValueLabel.text = blueTextField.text
        }
        }
        paintCanvas()
        } else {
            showAlert(with: "Ошибка", and: "В поле введено число не соответствующее диапазону 0 -> 1", for: textField)
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        oldColor = numberValue
    }
}

extension SettingsViewController {
    private func showAlert(with title: String, and message: String, for textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        textField.text = String(oldColor)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension UITextField {
    
    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
