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

    private var thereAreMoreCardsArray = [CardData]() {
        didSet {
            DispatchQueue.main.async {
                self.moreCardView.collectionV.reloadData()

            }
        }
    }
    
    override func loadView() {
        view = moreCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
//
  moreCardView.collectionV.dataSource = self
        moreCardView.collectionV.delegate = self
//
       moreCardView.collectionV.register(moreCardsCell.self, forCellWithReuseIdentifier: "moreCell")
//        fetchCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCards()
    }
    
      private func fetchCards(){
        thereAreMoreCardsArray = CardData.getData()

//          CardsAPIClient.getTheCardInfo {
//              [weak self]
//              (result) in
//              switch result {
//              case .failure(let error):
//                             print("well its not working\(error)")
//              case .success(let cards):
//                  self?.thereAreMoreCardsArray = cards
//              }
//          }
      }
}



extension SearchingForMoreCardsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         // this is where you return the actual size of the cell.
         let maxSize: CGSize = UIScreen.main.bounds.size
         let itemWidth: CGFloat = maxSize.width
         // MARK: this is to change the height of the cell
         let itemHeight: CGFloat = maxSize.height * 0.15 // make it 30%
         return CGSize(width: itemWidth, height: itemHeight)
     }
}

extension SearchingForMoreCardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thereAreMoreCardsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moreCell", for: indexPath) as? moreCardsCell else {
            fatalError("couldnt dequqe... ")
        }
        
        
        let selectedCard = thereAreMoreCardsArray[indexPath.row]
      //  cell.delegate is the delegate set here?????
        cell.delegate = self
        cell.backgroundColor = .white
    
       cell.configureCell(for: selectedCard)
        return cell
    }
}

extension SearchingForMoreCardsController: MoreCardsCellDelegate {
    func didSelectAddButton(_ moreCardsCell: moreCardsCell, aCard: CardData) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
              
              let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
                     
        let addAction = UIAlertAction(title:"Add", style: .default) {
                         alertAction in
                       
                        print("should have added because we are inside of the addAction")
            self.addCardToTheOtherController(aCard)
            
                     }
                     
                     alertController.addAction(cancelAction)
                     alertController.addAction(addAction)
                     
                     present(alertController, animated: true)
    }
    
    
    private func addCardToTheOtherController(_ aCard: CardData){//
        
        // because we have a parameter of a article that will need to be put in the index will be the index of whatever article that is put into the function...
//        guard let index = thereAreMoreCardsArray.firstIndex(of: aCard) else {
//            return
//        }
        
        do{
            print("we are now inside of the do catch for the custom delegate of the search controller.")
            try dP.createItem(aCard)
        }catch{
            print("error deleting article")
        }
    }
    
}
