//
//  CreatingCardsView.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreatingCardsView: UIView {

    public lazy var titleText: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter the title here")
        textField.autocorrectionType = .yes
        textField.backgroundColor = .systemBlue
        textField.textAlignment = .center
        
        return textField
    }()
       
    public lazy var firstFactText: UITextField = {
         let textField = UITextField()
         textField.attributedPlaceholder = NSAttributedString(string: "Enter one fact here")
         textField.autocorrectionType = .yes
        textField.backgroundColor = .gray
        textField.textAlignment = .center

         return textField
     }()
    
    public lazy var secondFactText: UITextField = {
         let textField = UITextField()
         textField.attributedPlaceholder = NSAttributedString(string: "Enter the next fact here please.")
         textField.autocorrectionType = .yes
        textField.backgroundColor = .purple
         textField.textAlignment = .center

         return textField
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
       setUpTitleTextConstraints()
        setupfirstFactTextConstraints()
        setupsecondFactTextConstraints()
     }
    
    private func setUpTitleTextConstraints(){
        addSubview(titleText)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleText.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
    }
    
       private func setupfirstFactTextConstraints(){
           addSubview(firstFactText)
        firstFactText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstFactText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            firstFactText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            firstFactText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            firstFactText.heightAnchor.constraint(equalToConstant: 50 )              ])
    
       }
    
    private func setupsecondFactTextConstraints(){
        addSubview(secondFactText)
        secondFactText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondFactText.topAnchor.constraint(equalTo: firstFactText.bottomAnchor, constant: 10),
            secondFactText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            secondFactText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            secondFactText.heightAnchor.constraint(equalToConstant: 50 )
               ])
        
    }
   
    
   
    

}
