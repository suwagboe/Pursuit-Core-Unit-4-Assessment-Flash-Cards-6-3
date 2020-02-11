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
    
    override func loadView() {
       view = createsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
       // createsView.firstFactText.de
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
