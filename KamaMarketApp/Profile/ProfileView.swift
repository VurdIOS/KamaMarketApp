//
//  ProfileView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import UIKit

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
            frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 300),
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
            frame: CGRect(x: 0, y: 500, width: view.frame.width, height: 100),
            models:[
                ProfileCellModel(
                    icon: "ProfileExit",
                    name: "Выйти",
                    handler: { self.exitButtonTapped() })
            ])
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        setupNavBar()
        view.addSubview(profileIcon)
        view.addSubview(tableView)
        view.addSubview(tableView2)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            profileIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            profileIcon.widthAnchor.constraint(equalToConstant: 80),
            profileIcon.heightAnchor .constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 30)
//            nameLabel.widthAnchor.constraint(equalToConstant: 80),
//            nameLabel.heightAnchor .constraint(equalToConstant: 80)
        ])
    }
    private func likedStuffButtonTapped() {

    }
    private func myStuffButtonTapped() {
        
    }
    private func exitButtonTapped() {
        
    }
    
    private func setupNavBar() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 50))
        
        navbar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navbar.shadowImage = UIImage()
        self.view.addSubview(navbar)

        let navItem = UINavigationItem(title: "Профиль")
        let changeImageButton = UIImage(named: "ChangeNavButton")?.withRenderingMode(.alwaysOriginal)
        let navBarButton = UIBarButtonItem(image: changeImageButton, style: .done, target: self, action: .none)
        navItem.rightBarButtonItem = navBarButton

        navbar.items = [navItem]
    }
}
