//
//  ProfileView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import UIKit
import Firebase

class ProfileView: UIViewController {
    
    let profileIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "UserIcon"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Алеся"
        lbl.font = UIFont.systemFont(ofSize: 20)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let bgColor = UIColor.white
    
    lazy var tableView: ProfileTableView = {
        let table = ProfileTableView(
            frame: CGRect(x: 0, y: 260, width: view.frame.width, height: 300),
            models:[
                ProfileCellModel(
                    icon: "ProfileLiked",
                    name: "Понравившиеся",
                    handler: { self.likedStuffButtonTapped() }),
                ProfileCellModel(
                    icon: "ProfileStaff",
                    name: "Мои товары",
                    handler: { self.myStuffButtonTapped()})
            ])
        return table
    }()
    lazy var tableView2: ProfileTableView = {
        let table = ProfileTableView(
            frame: CGRect(x: 0, y: 420, width: view.frame.width, height: 100),
            models:[
                ProfileCellModel(
                    icon: "ProfileExit",
                    name: "Выйти",
                    handler: { self.exitButtonTapped() })
            ])
        return table
    }()
    
    lazy var finishRegistrationButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Закончить регистрацию", for: .normal)
        btn.backgroundColor = UIColor.AccentColor
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(finishRegistrationButtonTapped), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupNavBar()
        title = "asd"
        view.addSubview(profileIcon)
        view.addSubview(nameLabel)
        view.addSubview(tableView)
        view.addSubview(tableView2)
        view.addSubview(finishRegistrationButton)
        
        
        NSLayoutConstraint.activate([
            profileIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            profileIcon.widthAnchor.constraint(equalToConstant: 80),
            profileIcon.heightAnchor .constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 20)
//            nameLabel.widthAnchor.constraint(equalToConstant: 80),
//            nameLabel.heightAnchor .constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            finishRegistrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishRegistrationButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 1 - (tabBarController?.tabBar.frame.size.height ?? 80)  - 80),
            finishRegistrationButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            finishRegistrationButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    @objc private func changesButtonTapped() {
        let vc = ChangeProfileView()
//        navigationController?.pushViewController(vc, animated: true)
        print("@#@32")
    }

    private func likedStuffButtonTapped() {
        let vc = ProfileLikedView()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    private func myStuffButtonTapped() {
        let vc = ProfileMyStaffView()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func exitButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let vc = AuthorizationViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.hidesBackButton = true
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    @objc private func finishRegistrationButtonTapped() {
        //TODO
    }
    
    private func setupNavBar() {
        
        
//        self.title = "Регистрация"
//        let backImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(changesButtonTapped))
//
////        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 50))
//        navigationController?.navigationBar.topItem =
//
//        navbar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navbar.shadowImage = UIImage()
//
//        let button = UIButton()
//        button.setImage(UIImage(named: "rainbow-circle"), for: .normal)
////        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
//        navbar.inputAccessoryViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
//
//
//        let navItem = UINavigationItem(title: "Профиль")
//        let changeImageButton = UIImage(named: "ChangeNavButton")?.withRenderingMode(.alwaysOriginal)
//        let navBarButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(changesButtonTapped))
////        navigationItem.rightBarButtonItem = navBarButton
//        navbar.items = [navItem]
//
//        self.view.addSubview(navbar)
    }
}
