//
//  ViewController.swift
//  StarRating
//
//  Created by Craig Swanson on 11/21/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func updateRating(_ ratingControl: CustomControl) {
        
        var userRating = ratingControl.value
        
        if userRating == 1 {
            self.title = "User Rating: \(userRating) Star"
        } else {
            self.title = "User Rating: \(userRating) Stars"
        }
    }
    
}

