//
//  LookAtMyCardsController.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class LookAtMyCardsController: UIViewController {
    /*
     want to be able to delete the card if they choose.
     needs a more button.. 
     */
    
    public var dataP : DataPersistence<String>!
    
    private var cardsView = LookAtMyCardsView()

    override func loadView() {
        view = cardsView
    }
    
    //need the model to populate things inside of my collection view...
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsView.collectionV.dataSource = self
        cardsView.collectionV.delegate = self
        
        cardsView.searchBar.delegate = self

        // need to set the cell here.
        
        cardsView.collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cardsCell")
        
        view.backgroundColor = .systemGroupedBackground
    }
    

}

extension LookAtMyCardsController: UISearchBarDelegate {
    
}

extension LookAtMyCardsController: UICollectionViewDelegateFlowLayout {
    
}

extension LookAtMyCardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath)
        
        cell.backgroundColor = .white
        
        return cell
    }
}
