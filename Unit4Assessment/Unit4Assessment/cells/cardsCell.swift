//
//  cardsCell.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import  ImageKit

protocol CardsCellDelegate: AnyObject {
   
    func didSelectMoreButton(_ cardsCell: cardsCell, aCard: CardData)
}
class cardsCell: UICollectionViewCell {
    // setting the delegate
    weak var delegate: CardsCellDelegate?

    private var currentCard: CardData!
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
            let gesture  = UILongPressGestureRecognizer()
            gesture.addTarget(self, action: #selector(didLongPress(_:)))
            return gesture
        }()
       
    // MARK: this is the button...
     public lazy var moreButton: UIButton = {
          let button = UIButton()
            button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
            button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
         
            return button
        }()
    public lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .systemPink
        return label
    }()
    
    public lazy var factOne: UILabel = {
          let label = UILabel()
              label.numberOfLines = 2
              label.font = UIFont.preferredFont(forTextStyle: .caption1)
              label.textColor = .blue
        label.alpha = 0
              return label
    }()
    
    public lazy var factTwo: UILabel = {
             let label = UILabel()
                 label.numberOfLines = 2
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
        setUpCardTitleConstraints()
        setUpButtonConstraints()
            setUpfactOneConstraints()
        setUpfactTwoConstraints()
        cardTitle.isUserInteractionEnabled = true
                                   addGestureRecognizer(longPressGesture)
    }

    @objc private func moreButtonPressed(_ sender: UIButton){
        print("button was pressed for article \(currentCard.quizTitle)")
          delegate?.didSelectMoreButton(self, aCard: currentCard)
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
     }
    private func setUpButtonConstraints(){
        addSubview(moreButton)
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44)
            // it is 44 because in the apple doc that is what they say to use
            ,
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        
        ])
    }

    private func setUpCardTitleConstraints(){
        addSubview(cardTitle)
        
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTitle.topAnchor.constraint(equalTo: topAnchor),
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }

    private func setUpfactTwoConstraints() {
          addSubview(factTwo)
           
           factTwo.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               factTwo.topAnchor.constraint(equalTo: topAnchor, constant: 10),
               factTwo.leadingAnchor.constraint(equalTo: leadingAnchor),
               factTwo.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant:  8),
               factTwo.bottomAnchor.constraint(equalTo: factOne.topAnchor, constant: -8)
           ])
       }
    
       private func setUpfactOneConstraints() {
           addSubview(factOne)
               
               factOne.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   factOne.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
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
