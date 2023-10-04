//
//  FallingAlert.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 14.08.2023.
//

import UIKit

class FallingAlert: UIView {
    
    
    let image = UIImageView(image: UIImage(named: "warning"))
    let label: UILabel = {
        let label = UILabel()
        label.text = " Неправильный логин или пароль"
        label.textColor = .white
         
        label.translatesAutoresizingMaskIntoConstraints = false
         
         return label
     }()
    let hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loginErrorViewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loginErrorViewSetup() {
        self.backgroundColor = UIColor(red: 243/255, green: 69/255, blue: 69/255, alpha: 1)
        self.layer.cornerRadius = 15

        hStack.addArrangedSubview(image)
        hStack.addArrangedSubview(label)
        
        self.addSubview(hStack)
        
        hStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        hStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}



