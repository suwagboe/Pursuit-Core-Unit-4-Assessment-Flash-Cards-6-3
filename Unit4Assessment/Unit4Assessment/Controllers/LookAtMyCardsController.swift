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
    
    public var dataP : DataPersistence<CardData>!
    
    private let cardsView = LookAtMyCardsView()
    
    public var addedCards = [CardData]() {
        didSet{
            DispatchQueue.main.async {
                self.cardsView.collectionV.reloadData()
            }
        }
    }
    
    private var anotherArr = Set([CardData]())
    
    override func loadView() {
         view = cardsView
     }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsView.collectionV.dataSource = self
        cardsView.collectionV.delegate = self
        
        cardsView.searchBar.delegate = self
        
        cardsView.collectionV.register(cardsCell.self, forCellWithReuseIdentifier: "cardsCell")
        
        view.backgroundColor = .systemGroupedBackground
        fetchCards()
      //  checkForDuplicates()
    }

      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          fetchCards()
       // checkForDuplicates()
      }
      
    private func fetchCards(){
        do {
            addedCards = try dataP.loadItems()
            }catch {
            print("these are the errors \(error)")
        }
    }
    
 
    private func checkForDuplicates() {
       
        for card in addedCards {
            //if card.id ==
            if addedCards.contains(card){
                anotherArr.insert(card)
            }
        }
    }
    
    
}

/*
 for card in addedCards{
     if let index = addedCards.firstIndex(of: card) {
                             addedCards.remove(at: index)
         return
     }

 */

extension LookAtMyCardsController: UISearchBarDelegate {
    
}

extension LookAtMyCardsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // this is where you return the actual size of the cell.
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        // MARK: this is to change the height of the cell
        let itemHeight: CGFloat = maxSize.height * 0.15 // make it 30%
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // it inheretes from scroll view....
        // the delegate object has the scroll object on it
       if cardsView.searchBar.isFirstResponder {
        // when we scroll it dismisses the keyboard
            cardsView.searchBar.resignFirstResponder()
        }
    }
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
        cell.delegate = self
        cell.backgroundColor = .white
        cell.configureCell(for: selectedCard)
        return cell
    }
}

extension LookAtMyCardsController: CardsCellDelegate {
    func didSelectMoreButton(_ cardsCell: cardsCell, aCard: CardData) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
               
               let deleteAction = UIAlertAction(title:"delete", style: .destructive) {
                   alertAction in
                   //write a delelte helper function in order to actually delete something...
                print("it will be printed")
                   self.deleteAcard(aCard) // to remove the article
                   // the delegate method is getting called
                self.fetchCards()
               }
               alertController.addAction(cancelAction)
               alertController.addAction(deleteAction)
               
               present(alertController, animated: true)
    }
    
    private func deleteAcard(_ aCard: CardData){//
           
        guard let index = addedCards.firstIndex(of: aCard) else {
               return
           }
           do{
               try dataP.deleteItem(at: index)
           }catch{
               print("error deleting article")
           }
       }
}

extension LookAtMyCardsController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchCards()
        
    }
}
