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
    
    private var selectedCard : CardData?
    
    let mainControllerInstance = LookAtMyCardsController()
    
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
        moreCardView.collectionV.register(MoreCardsCell.self, forCellWithReuseIdentifier: "moreCell")
        fetchCards()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchCards()
    }
    
    private func fetchCards(){
        thereAreMoreCardsArray = CardData.getData()
        
    }
}

extension SearchingForMoreCardsController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("It was saved")
        fetchCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchCards()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theCard = thereAreMoreCardsArray[indexPath.row]
        selectedCard = theCard
    }
}

extension SearchingForMoreCardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thereAreMoreCardsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moreCell", for: indexPath) as? MoreCardsCell else {
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
    func didSelectAddButton(_ moreCardsCell: MoreCardsCell, aCard: CardData) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        let addAction = UIAlertAction(title:"Add", style: .default) {
            alertAction in
            print("should have added because we are inside of the addAction")
            // let cardInfo = CardData(id: aCard.id, quizTitle: aCard.quizTitle, facts: aCard.facts, userId: "shaniya", currentDate: Date())
            //                for acard in self.mainControllerInstance.addedCards {
            //                    if self.mainControllerInstance.addedCards.contains(acard){
            //                        self.showAlert(title: "sorry this card is already there", message: "this card is already in your cards.")
            //                    } else {
            
            if self.dP.hasItemBeenSaved(aCard){
                if (try? self.dP.loadItems().firstIndex(of: aCard)) != nil {
                    //do {
                        DispatchQueue.main.async{
                            self.showAlert(title: "sorry this card is already there", message: "this card is already in your cards.")
                        }
                       // try self.dP.deleteItem(at: index)
//                    } catch {
//                        print("error deleting article: \(error)")
//                    }
                } }else {
               do {
                    // save to documents directory
                    try self.dP.createItem(aCard)
                    DispatchQueue.main.async {
                       // self.addCardToTheOtherController(aCard)
                        self.showAlert(title: "You added a new card", message: "The card you selected has been added to your list.")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            // your code here delayed by 0.5 seconds
                            
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                } catch {
                    print("error saving article: \(error)")
                }
            }
        }
        //self.tabBarController?.selectedIndex = 0
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true)
    }
    
    private func addCardToTheOtherController(_ aCard: CardData){
        print("we are now inside of the do catch for the custom delegate of the search controller.")
        
        do{
            try  dP.createItem(aCard)
            print("the card was saved")
        }catch{
            print("error deleting article\(error)")
        }
        
    }
}
