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
    
    public let theCreatedCard: CardData? = nil 
    
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
              
          }
}

extension CreatingCardsController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if createsView.titleText.text!.isEmpty {
            //the show an alert
            
        } else if createsView.firstFactText.text!.isEmpty{
            
        } else if createsView.secondFactText.text!.isEmpty {
            
        }
        
        return true 
    }
    
}
