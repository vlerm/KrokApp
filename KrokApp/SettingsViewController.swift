//
//  SettingsViewController.swift
//  KrokApp
//
//  Created by Вадим Лавор on 2.08.22.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openSafari(_ sender: UIButton) {
        if let url = URL(string: Utilities.krokAppAboutStringUrl) {
            UIApplication.shared.open(url)
        }
    }
    
}
