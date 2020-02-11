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
        textField.backgroundColor = .red
        return textField
    }()
       
    public lazy var firstFactText: UITextField = {
         let textField = UITextField()
         textField.attributedPlaceholder = NSAttributedString(string: "Enter one fact here")
         textField.autocorrectionType = .yes
        textField.backgroundColor = .gray
         return textField
     }()
    
    public lazy var secondFactText: UITextField = {
         let textField = UITextField()
         textField.attributedPlaceholder = NSAttributedString(string: "Enter the next fact here please.")
         textField.autocorrectionType = .yes
        textField.backgroundColor = .black
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
            titleText.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleText.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        
    }
    
       private func setupfirstFactTextConstraints(){
           addSubview(firstFactText)
        firstFactText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstFactText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            firstFactText.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstFactText.trailingAnchor.constraint(equalTo: trailingAnchor),
            //firstFactText.heightAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutDimension>#>)
               ])
    
       }
    
    private func setupsecondFactTextConstraints(){
        addSubview(secondFactText)
        secondFactText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondFactText.topAnchor.constraint(equalTo: firstFactText.bottomAnchor, constant: 10),
            secondFactText.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondFactText.trailingAnchor.constraint(equalTo: trailingAnchor),
               ])
        
    }
   
    
   
    

}
