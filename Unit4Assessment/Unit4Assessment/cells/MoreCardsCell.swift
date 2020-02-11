//
//  MoreCardsCell.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol MoreCardsCellDelegate: AnyObject {
   
    func didSelectAddButton(_ moreCardsCell: MoreCardsCell, aCard: CardData)
}
class MoreCardsCell: UICollectionViewCell {
    // setting the delegate
    weak var delegate: MoreCardsCellDelegate?

    private var currentCard: CardData!

    private lazy var longPressGesture: UILongPressGestureRecognizer = {
         let gesture  = UILongPressGestureRecognizer()
         gesture.addTarget(self, action: #selector(didLongPress(_:)))
         return gesture
     }()
    
    // MARK: this is the button...
       public lazy var addButton: UIButton = {
            let button = UIButton()
              button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
            
              button.addTarget(self, action: #selector(AddButtonPressed(_:)), for: .touchUpInside)
           
              return button
          }()
    
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
        // need to set the aplha of one in order for it to toggle properly
              label.alpha = 0
              return label
    }()
    
    public lazy var factTwo: UILabel = {
             let label = UILabel()
                 label.numberOfLines = 3
                 label.font = UIFont.preferredFont(forTextStyle: .caption1)
                 label.textColor = .orange
         label.alpha = 0
                 return label
       }()
    
    private var isCurrentCardTitleShowing = true
    
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
        setUpfactOneConstraints()
       setUpfactTwooConstraints()
        cardTitle.isUserInteractionEnabled = true
                            addGestureRecognizer(longPressGesture)
        
    }

    @objc private func AddButtonPressed(_ sender: UIButton){
        // this is the button itself
        print("button was pressed for article \(currentCard.quizTitle)")
        delegate?.didSelectAddButton(self, aCard: currentCard)
        
      }
    
       @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer){
           print("outside gesture")
        guard currentCard != nil else { return }

           if gesture.state == .began || gesture.state == .changed {
               print("long pressed")
               return
           }
           isCurrentCardTitleShowing.toggle() // true -> false
        animate()

       }
    
    // to make it turn..
    private func animate() {
         let duration: Double = 1.0
         if isCurrentCardTitleShowing {
             // self is the sell
             UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                 // this closure is not a network request does not need weak self no network call
                 self.cardTitle.alpha = 1.0
                 self.factOne.alpha = 0.0
                self.factTwo.alpha = 0.0
                 
             }, completion: nil )
         } else {
             UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                 // this closure is not a network request does not need weak self no network call
                 self.cardTitle.alpha = 0.0
                 self.factOne.alpha = 1.0
                self.factTwo.alpha = 1.0
             }, completion: nil )
             
         }
     }// the end of the animate function
   
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
    
    private func setUpfactTwooConstraints() {
       addSubview(factTwo)
        
        factTwo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            factTwo.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            factTwo.leadingAnchor.constraint(equalTo: leadingAnchor),
            factTwo.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant:  8),
            factTwo.bottomAnchor.constraint(equalTo: factOne.topAnchor, constant: -8)
        ])
    }
 
    private func setUpfactOneConstraints() {
        addSubview(factOne)
            
            factOne.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                factOne.topAnchor.constraint(equalTo: addButton.bottomAnchor),
                factOne.leadingAnchor.constraint(equalTo: leadingAnchor ),
                factOne.trailingAnchor.constraint(equalTo: trailingAnchor ),
                factOne.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    // need to add the constraints for the card title..
    
    public func configureCell(for addedCard: CardData){
           currentCard = addedCard // associating the cell with its article
           // need to set the article or it will be nil and it will crash
           cardTitle.text = addedCard.quizTitle
        factOne.text = addedCard.facts.first
        factTwo.text = addedCard.facts.last
           
       }
    
}
