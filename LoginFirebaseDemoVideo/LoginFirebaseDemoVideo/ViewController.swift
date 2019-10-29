//
//  ViewController.swift
//  LoginFirebaseDemoVideo
//
//  Created by Arman Vaziri on 10/21/19.
//  Copyright © 2019 ArmanVaziri. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // email: arman@gmail.com
    // password: iosiscool
    
    @IBAction func loginAction(_ send: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil {
                print("valid user")
                let alertController = UIAlertController(title: "HELLO!", message: "Welcome to Firebase (:", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("invalid user")
                let alertController = UIAlertController(title: "GO AWAY!", message: "You are not valid! ):<", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }


}

