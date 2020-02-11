//
//  MoreCardsCell.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol MoreCardsCellDelegate: AnyObject {
   
    func didSelectAddButton(_ moreCardsCell: moreCardsCell, aCard: CardData)
}

class moreCardsCell: UICollectionViewCell {
    // setting the delegate
    weak var delegate: MoreCardsCellDelegate?

    private var currentCard: CardData!
    /*
     cell has
     a title
        2 facts
     
     */
    
    public lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .systemPink
        return label
    }()
    
    public lazy var factOne: UILabel = {
          let label = UILabel()
              label.numberOfLines = 0
              label.font = UIFont.preferredFont(forTextStyle: .caption1)
              label.textColor = .blue
              return label
    }()
    
    public lazy var factTwo: UILabel = {
             let label = UILabel()
                 label.numberOfLines = 0
                 label.font = UIFont.preferredFont(forTextStyle: .caption1)
                 label.textColor = .orange
                 return label
       }()
    
    // MARK: this is the button...
    
    public lazy var addButton: UIButton = {
         let button = UIButton()
           button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
           // need to set up the action for the button so the target needs to be added inside of the button properties
           button.addTarget(self, action: #selector(AddButtonPressed(_:)), for: .touchUpInside)
           //because we are using custom delegation so we are setting it up here
           return button
       }()
    
    private var isCurrentCardTitleShowing = false
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpButtonConstraints()
        setUpCardTitleConstraints()
       

    }

    @objc private func AddButtonPressed(_ sender: UIButton){
        print("button was pressed for article \(currentCard.quizTitle)")
        delegate?.didSelectAddButton(self, aCard: currentCard)
      }
    
    // to make it turn..
    private func animate() {
         let duration: Double = 1.0
         if isCurrentCardTitleShowing {
             // self is the sell
             UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                 // this closure is not a network request does not need weak self no network call
                 self.cardTitle.alpha = 1.0
                 self.factTwo.alpha = 0.0
                 
             }, completion: nil )
         } else {
             UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                 // this closure is not a network request does not need weak self no network call
                 self.cardTitle.alpha = 0.0
                 self.factTwo.alpha = 1.0
                 
             }, completion: nil )
             
         }
     }
    private func setUpButtonConstraints(){
        addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 44)
            // it is 44 because in the apple doc that is what they say to use
            ,
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
        
        ])
    }

    private func setUpCardTitleConstraints(){
        addSubview(cardTitle)
        
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTitle.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    // need to add the constraints for the card title..
    
    public func configureCell(for addedCard: CardData){
           currentCard = addedCard // associating the cell with its article
           // need to set the article or it will be nil and it will crash
           cardTitle.text = addedCard.quizTitle
        factOne.text = addedCard.facts.first
           
       }
    
}
