//
//  CreatingCardsController.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreatingCardsController: UIViewController {
    
    public var dp : DataPersistence<CardData>!
   
    private let createsView = CreatingCardsView()
    
    private var theCreatedCard: CardData?
    
    override func loadView() {
       view = createsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
       // createsView.firstFactText.de
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTheCardToTheArray(_:)))
        
        createsView.titleText.delegate = self
        createsView.firstFactText.delegate = self
        createsView.secondFactText.delegate = self
    }
    
    

    @objc
          private func addTheCardToTheArray(_ sender: UIBarButtonItem){
        guard let cardTitle = createsView.titleText.text, !cardTitle.isEmpty, let firstFact = createsView.firstFactText.text, !firstFact.isEmpty, let secondFact = createsView.secondFactText.text, !secondFact.isEmpty else {
     showAlert(title: "you aren't done", message: "please double check that everything is filled in.")
            return
        }
        showAlert(title: "Your GOOD", message: "the new card you made has now been added")
        theCreatedCard = CardData(id: String.getISOTimestamp(), quizTitle: cardTitle, facts: [firstFact, secondFact], userId: "shaniya")
        
        do{
          try dp.createItem(theCreatedCard!)
        }catch {
           showAlert(title: "something, went wrong", message: "this didn't save propery.. please try again.")
        }
          }
    
    /*
     guard let card = theCreatedCard else {
                   return
               }
            
                  print("saved an article button p ressed")
               do {
                   // saved to  the documents directory
                   try dp.createItem(card)
                   // alert that the time was saved
                   
               }catch {
                   print("error saving article: \(error)")
               }
               
               // this is where the delegate comes in because after it is saved it needs to be passed...
                  
     */
    
    
}

extension CreatingCardsController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true 
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

     guard range.location == 0 else {
            return true
        }

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
    }
    
}

extension CreatingCardsController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("if we are in here then it is saving BABY.")
    
        
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("Its deleting this.")
    }
    
    
}
