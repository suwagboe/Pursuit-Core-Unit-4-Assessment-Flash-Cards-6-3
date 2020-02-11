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
    
    private let cardsView = LookAtMyCardsView()
    
    //need the model to populate things inside of my collection view...
    
    // an array of cards
    
    private var addedCards = [CardData]() {
        didSet{
            DispatchQueue.main.async {
                self.cardsView.collectionV.reloadData()
            }
        }
    }
    
    override func loadView() {
         view = cardsView
     }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsView.collectionV.dataSource = self
        cardsView.collectionV.delegate = self
        
        cardsView.searchBar.delegate = self

        // need to set the cell here.
        
        cardsView.collectionV.register(cardsCell.self, forCellWithReuseIdentifier: "cardsCell")
        
        view.backgroundColor = .systemGroupedBackground
        fetchCards()
    }
    
    
      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          fetchCards()
      }
      
    private func fetchCards(){
       addedCards = CardData.getData()
//        CardsAPIClient.getTheCardInfo {
//                 [weak self]
//                 (result) in
//                 switch result {
//                 case .failure(let error):
//                                print("well its not working\(error)")
//                 case .success(let cards):
//                     self?.addedCards = cards
//             }
//         }
    }

}

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
    
    // MARK: this is called here because it is an action and we want when the item is selected to transfer the data ...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      //  let article = addedCards[indexPath.row]
        
        
        // need an instance of article detail view controller
        //let articleDVC = AtrticleDetailController()
     
        //Todo: after assessment we will be using initilizers as dependency inhection mechanims ...
       // articleDVC.seguedArticle = article
        
        // this here segues the data persistence instence that we have here to the detail views datapersistence which is called dp...
        // giving it the same persistence instance that is here...
       // articleDVC.dp = dataPersistence
        
        // MARK: make sure that you embeed it in a nav controller
        // the below code WILL NOT WORK WITHOUT the newfeedController being embeeded because the navigationController is nil... and its nill because the main view controller does not have navigation controller..
        //navigationController?.pushViewController(articleDVC, animated: true)
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
      //  cell.delegate is the delegate set here?????
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
                   self.deleteAcard(aCard) // to remove the article
                   // the delegate method is getting called
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
