//
//  PokedexCollectionViewController.swift
//  Pokedex
//
//  Created by Entei on 2/26/19.
//  Copyright © 2019 iosdecal. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var pokedexCollectionView: UICollectionView!
    let pokedex = Pokedex()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexCollectionView.delegate = self
        pokedexCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokedex.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokedexCollectionCell", for: indexPath) as? PokedexCollectionViewCell {
            cell.pokedexCellImageView.image = pokedex.images[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(pokedex.names[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = self.pokedexCollectionView.frame.size.width / 4;
        return CGSize(width: dimension, height: dimension)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
