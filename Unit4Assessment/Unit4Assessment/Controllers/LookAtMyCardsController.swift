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
    
    private var instanceOfCardsView = LookAtMyCardsView()

    override func loadView() {
        view = instanceOfCardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
    }
    

}
