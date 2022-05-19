//
//  mainViewController.swift
//  ColorSliders
//
//  Created by Anton Vassel on 18.05.2022.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func setNewBackgroundColor (with color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.canvasBackgroundColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewBackgroundColor(with color: UIColor) {
        view.backgroundColor = color
    }
}
