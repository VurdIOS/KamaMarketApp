//
//  FallingAlert.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 14.08.2023.
//

import UIKit

class FallingAlert: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loginErrorViewSetup()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func loginErrorViewSetup() {
        
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 64).isActive = true
        label.widthAnchor.constraint(equalToConstant: self.frame.width - 56).isActive = true
        
        label.frame = self.bounds
    
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fullString = NSMutableAttributedString()
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: "warning")
        
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: " Неправильный логин или пароль", attributes: [.font: UIFont.systemFont(ofSize: 15)]))
        
        label.attributedText = fullString
        label.backgroundColor = UIColor(red: 243/255, green: 69/255, blue: 69/255, alpha: 1)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        
        
    }
}



