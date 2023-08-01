//
//  AuthorizationViewController.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.08.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    var logoView = UIImageView()
    var logoImage: UIImage!
    
    private var viewModel: AuthorizationViewModelProtocol! {
        didSet {
            logoImage = UIImage(named: viewModel.logoImage)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        viewModel = AuthorizationViewModel()
        setupLogo()
        view.addSubview(logoView)
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: view.frame.width - 300).isActive = true
    }
    
    func setupLogo() {
        logoView.image = logoImage
        logoView.clipsToBounds = true
        logoView.translatesAutoresizingMaskIntoConstraints = false
    }


}

