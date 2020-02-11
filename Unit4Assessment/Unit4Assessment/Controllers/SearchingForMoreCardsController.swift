//
//  SearchingForMoreCardsController.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchingForMoreCardsController: UIViewController {
    
    public var dP : DataPersistence<CardData>!
    
    private var moreCardView = MoreCardsView()

    override func loadView() {
        view = moreCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
        
        moreCardView.collectionV.dataSource = self
        moreCardView.collectionV.delegate = self
        
        moreCardView.collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "moreCell")
    }
    

}



extension SearchingForMoreCardsController: UICollectionViewDelegateFlowLayout {
    
}

extension SearchingForMoreCardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moreCell", for: indexPath)
        
        
      //  let selectedCard = addedCards[indexPath.row]
      //  cell.delegate is the delegate set here?????
        
        cell.backgroundColor = .white
    
       // cell.configureCell(for: selectedCard)
        return cell
    }
}
