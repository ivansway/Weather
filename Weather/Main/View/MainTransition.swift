//
//  MainTransition .swift
//  Weather
//
//  Created by Ivan Myrza on 10/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

extension MainUnit {
    
    @objc internal func pushMapVC() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let mapVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navController.pushViewController(mapVC, animated: true)
    
    }
}
