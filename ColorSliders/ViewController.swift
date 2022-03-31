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
        
        //Label setup
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        
        paintCanvas()
    }

    @IBAction func redColorAction() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        paintCanvas()
    }

    @IBAction func greenColorAction() {
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        paintCanvas()
    }
    
    @IBAction func blueColorAction() {
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        paintCanvas()
    }
    private func paintCanvas() {
        canvasView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
}

