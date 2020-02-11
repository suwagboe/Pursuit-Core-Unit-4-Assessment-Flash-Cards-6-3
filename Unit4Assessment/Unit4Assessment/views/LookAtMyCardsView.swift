//
//  LookAtMyCardView.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class LookAtMyCardsView: UIView {

    /*
     search bar
     collection view
     
     */
    public lazy var searchBar: UISearchBar = {
       let sb = UISearchBar()
        
        sb.autocapitalizationType = .none
        sb.placeholder = "what are you looking for?"
        
        return sb
    }()
   
    public lazy var collectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
              layout.scrollDirection = .vertical
              
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
              
              cv.backgroundColor = .systemOrange
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpSBContraints()
        setUpCollectionView()
        
    }
    private func setUpSBContraints(){
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false // this will allow for the auto layout infomation to be added instead of the main one
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpCollectionView(){
        addSubview(collectionV)
        
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionV.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionV.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionV.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}
