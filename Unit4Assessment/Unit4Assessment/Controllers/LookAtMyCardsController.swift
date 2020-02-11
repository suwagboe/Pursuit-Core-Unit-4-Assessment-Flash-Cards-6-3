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
    
    public var dataP : DataPersistence<CardData>!
    
    private var cardsView = LookAtMyCardsView()

    override func loadView() {
        view = cardsView
    }
    
    //need the model to populate things inside of my collection view...
    
    // an array of cards
    
    private var addedCards = [CardData]() {
        didSet{
            self.cardsView.collectionV.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsView.collectionV.dataSource = self
        cardsView.collectionV.delegate = self
        
        cardsView.searchBar.delegate = self

        // need to set the cell here.
        
        cardsView.collectionV.register(cardsCell.self, forCellWithReuseIdentifier: "cardsCell")
        
        view.backgroundColor = .systemGroupedBackground
    }
    private func fetchCards(){
        CardsAPIClient.getTheCardInfo {
            [weak self]
            (result) in
            switch result {
            case .failure:
                break
            case .success(let cards):
                self?.addedCards = cards
            }
        }
    }

}

extension LookAtMyCardsController: UISearchBarDelegate {
    
}

extension LookAtMyCardsController: UICollectionViewDelegateFlowLayout {
    
}

extension LookAtMyCardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedCards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath) as? cardsCell else {
            fatalError("couldn't dequqe as cardsCell")
        }
        
        let selectedCard = addedCards[indexPath.row]
      //  cell.delegate is the delegate set here?????
        
        cell.backgroundColor = .white
        cell.configureCell(for: selectedCard)
        return cell
    }
}
