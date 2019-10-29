//
//  ViewController.swift
//  NetworkingGesturesDemo
//
//  Created by Arman Vaziri on 10/20/19.
//  Copyright © 2019 ArmanVaziri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jokerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
           print("Recieved image tapped gesture!")
           nameLabel.textColor = UIColor.red
           publisherLabel.textColor = UIColor.green
       }
    
    
    let imageURL: String = "https://www.superherodb.com//pictures2//portraits//10//100//719.jpg"
    let infoURL: String = "https://superheroapi.com/api/2666726053447371/370/biography"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        loadInfo()
        jokerImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func loadImage() {
        
        guard let url = URL(string: imageURL) else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error == nil {
                guard let data = data else {return}
                let image = UIImage.init(data: data)
                DispatchQueue.main.async {
                    self.jokerImage.image = image
                }
            }
        })
        task.resume()
    }

    func loadInfo() {
    
        guard let url = URL(string: infoURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataresponse = data,
                error == nil else {
                  print("print error")
            return }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Joker.self, from: dataresponse)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = model.name
                    self.publisherLabel.text = model.publisher
                }
                } catch let parsingError {
                print("sorry parsing error")
            }
        }
        task.resume()
    }

}

struct Joker: Decodable {
    
    let name: String
    let publisher: String
    
}


