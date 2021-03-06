//
//  TabController.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class TabController: UITabBarController {
    
/*
     instance of persistence
     3 tabs:
        - card tab
        - create tab
        - search for new ones tab
     */

    private var dataPersistence = DataPersistence<CardData>(filename: "savedCards.plist")
    
    private lazy var LAMCC: LookAtMyCardsController = {
      let controller = LookAtMyCardsController()
            controller.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "doc.plaintext"), tag: 0)
        controller.dataP = dataPersistence
            return controller
    }()
    
    private lazy var CCC: CreatingCardsController = {
        let controller = CreatingCardsController()
              controller.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "pencil.and.outline"), tag: 1)
        controller.dp = dataPersistence
              return controller
    }()
    
    private lazy var SFMCC: SearchingForMoreCardsController = {
        let controller = SearchingForMoreCardsController()
              controller.tabBarItem = UITabBarItem(title: "search for more", image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 2)
        controller.dP = dataPersistence
              return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
// do I need a naviagtion controller in order to pass things
        view.backgroundColor = .systemGroupedBackground
        viewControllers = [UINavigationController(rootViewController: LAMCC), UINavigationController(rootViewController: CCC)
            , UINavigationController(rootViewController: SFMCC)]
    }

}
