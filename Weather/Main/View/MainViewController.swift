//
//  MainViewController.swift
//  Weather
//
//  Created by Ivan Myrza on 09/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var unit: MainUnit?
    private var maainVM = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    // SETUP
    private func setup() {
        
        // HIDE NAV BAR
        self.navigationController?.navigationBar.isHidden = true
        
        // UNIT INIT
        self.unit = MainUnit(superView: self.view, navController: self.navigationController ?? UINavigationController())
    }
}
