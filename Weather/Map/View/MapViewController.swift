//
//  MapViewController.swift
//  Weather
//
//  Created by Ivan Myrza on 10/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    private var map: Map?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        
        // BACK BUTTON
        backButton()
        
        // MAP INIT
        map = Map(superView: self.view)
    }
    
    private func backButton() {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Optipma", size: 22)
        button.titleLabel?.textAlignment = .left
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        button.layer.cornerRadius = 7
        button.setTitleColor(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(popMapVC), for: .touchUpInside)
        Constraints.widthHeightLeadingTop(superView: view, view: button, widthAnchor: 80, heightAnchor: 30, leadingAnchor: 16, topAnchor: 40)
    }

}
