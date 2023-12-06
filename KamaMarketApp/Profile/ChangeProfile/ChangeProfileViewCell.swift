//
//  ChangeProfileViewCell.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 05.12.2023.
//

import UIKit

class ChangeProfileViewCell: UITableViewCell {

    let textfield = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textfield.backgroundColor = .white
        textfield.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textfield)
        textfield.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        textfield.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        textfield.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

