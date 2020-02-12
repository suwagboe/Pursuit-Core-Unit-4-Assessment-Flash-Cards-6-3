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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        theCreatedCard = nil 
        
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
        
        theCreatedCard = CardData(id: String.getISOTimestamp(), quizTitle: cardTitle, facts: [firstFact, secondFact], userId: "shaniya",currentDate: Date())
        
        if self.dp.hasItemBeenSaved(theCreatedCard!){
            // let index =
               if (try? self.dp.loadItems().firstIndex(of: theCreatedCard!)) != nil {
               // do{
                    DispatchQueue.main.async{
                        self.showAlert(title: "sorry this card is already there", message: "this card is already in your cards.")}
             //if let index = try? dataPersistence.loadItems().firstIndex(of: theCreatedCard!) {
                        print("brorororm")
                    
//                    try self.dp.deleteItem(at: index)
//                } catch {
//                    print("error deleting article: \(error)")
//                }
            }
        }else{
                do{
                    try dp.createItem(theCreatedCard!)
                    self.showAlert(title: "Your GOOD", message: "the new card you made has now been added")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // your code here delayed by 0.5 seconds
                        self.tabBarController?.selectedIndex = 0
                    }
                }catch {
                    showAlert(title: "something, went wrong", message: "this didn't save propery.. please try again.")
                }
            }
        
    }
}
    
    extension CreatingCardsController: UITextFieldDelegate {
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if theCreatedCard != nil {
                // should make the textfield empty after
                //https://stackoverflow.com/questions/37084537/how-to-clear-text-field
                createsView.firstFactText.text = ""
                createsView.secondFactText.text = ""
                createsView.titleText.text = ""
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            //https://stackoverflow.com/questions/37119804/how-to-prevent-empty-or-whitespaces-in-uitextfield-in-swift
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
