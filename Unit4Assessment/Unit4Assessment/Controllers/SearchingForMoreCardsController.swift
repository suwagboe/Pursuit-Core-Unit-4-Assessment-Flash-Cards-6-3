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
    
    private var moreCardsView = MoreCardsView()

    override func loadView() {
        view = moreCardsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
        
    }
    

}
