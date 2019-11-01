//
//  CameraViewController.swift
//  AVMapKitDemo
//
//  Created by Arman Vaziri on 10/31/19.
//  Copyright © 2019 ArmanVaziri. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
    }
    

    
}
