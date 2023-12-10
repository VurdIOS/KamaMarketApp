//
//  MainTabBarView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import UIKit
class MainTabBarView: UITabBarController {
    

    
    lazy var navCon = UINavigationController(rootViewController: generateVC(viewConroller: ProfileView(), title: "Профиль", image: UIImage(named: "TBUser")))

    override func viewDidLoad() {
        super.viewDidLoad()

        generateTabBar()
        setTabBarAppearance()
        setupAddButtonInTabBar()
        navigationItem.hidesBackButton = true

        
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewConroller: MainListView(),
                       title: "Главная",
                       image: UIImage(named: "TBHome")),
            generateVC(viewConroller: WalletView(),
                       title: "Кошелек",
                       image: UIImage(named: "TBWallet")),
            generateVC(viewConroller: ChatsView(),
                       title: "Чаты",
                       image: UIImage(named: "TBChat")),
            navCon
            
            
        ]
    }

    private func generateVC(viewConroller: UIViewController,
                            title: String,
                            image: UIImage?) -> UIViewController {
        viewConroller.tabBarItem.title = title
        viewConroller.tabBarItem.image = image
        return viewConroller
    }
    
 

    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 0
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height + 60
        let roundLayer = CAShapeLayer ( )
        let bezierPath = UIBezierPath(
            roundedRect: CGRect (
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height),
            cornerRadius: height / 4
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = UIColor.AccentColor
        tabBar.unselectedItemTintColor = UIColor.tabBarItemLight
    }

    func setupAddButtonInTabBar() {
        let addTBButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 25, y: -25, width: 50, height: 50))
        addTBButton.backgroundColor = .AccentColor
        addTBButton.setImage(UIImage(named: "TBPlus"), for: .normal)
        addTBButton.layer.cornerRadius = addTBButton.frame.height / 2

        tabBar.addSubview(addTBButton)
        addTBButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }

    @objc func addButtonAction() {
        let vc = AddView()
        navigationController?.pushViewController(vc, animated: true)
    }
}
