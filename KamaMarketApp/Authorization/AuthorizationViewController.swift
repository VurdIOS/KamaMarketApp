//
//  AuthorizationViewController.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.08.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    lazy var logoView: UIImageView = {
        let logo = UIImageView()
        logo.frame.size.width = view.frame.width - 40
        logo.frame.size.height = logo.frame.width * 0.127
        logo.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        //
        return logo
    }()
    var logoImage: UIImage!
    var heightAnc = NSLayoutConstraint()
    
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
        setupConstraints()
        updateConstraint()
    }
    
    func setupConstraints() {
        view.addSubview(logoView)
    }
    
    func updateConstraint() {
        UIView.animate(withDuration: 1,delay: 0.5,options: .curveEaseInOut ) { [self] in
            self.logoView.center = CGPoint(x: view.frame.width / 2, y: 150)
            self.view.layoutIfNeeded() // no needed
        }
    }
    
    func setupLogo() {
        logoView.image = logoImage
        logoView.clipsToBounds = true
        logoView.translatesAutoresizingMaskIntoConstraints = false
    }
}

