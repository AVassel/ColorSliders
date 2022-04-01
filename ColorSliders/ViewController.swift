//
//  ViewController.swift
//  ColorSliders
//
//  Created by Anton Vassel on 31.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var canvasView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.layer.cornerRadius = 25
        
        redValueLabel.text = string(for: redSlider)
        greenValueLabel.text = string(for: greenSlider)
        blueValueLabel.text = string(for: blueSlider)
        
        paintCanvas()
    }

    @IBAction func redColorAction() {
        redValueLabel.text = string(for: redSlider)
        paintCanvas()
    }

    @IBAction func greenColorAction() {
        greenValueLabel.text = string(for: greenSlider)
        paintCanvas()
    }
    
    @IBAction func blueColorAction() {
        blueValueLabel.text = string(for: blueSlider)
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
}

