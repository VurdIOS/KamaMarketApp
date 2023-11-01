//
//  MainTabBarView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import UIKit

class MainTabBarView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewConroller: MainListView(), title: "Главная", image: UIImage(named: "TBHome")),
            generateVC(viewConroller: WalletView(), title: "Кошелек", image: UIImage(named: "TBWallet")),
            generateVC(viewConroller: AddView(), title: "", image: UIImage(systemName: "house.fill")),
            generateVC(viewConroller: ChatsView(), title: "Чаты", image: UIImage(named: "TBChat")),
            generateVC(viewConroller: ProfileView(), title: "Профиль", image: UIImage(named: "TBUser"))
        ]
    }
    
    private func generateVC(viewConroller: UIViewController, title: String, image: UIImage?) -> UIViewController {
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
        tabBar.itemWidth = width / 6
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = UIColor.tabBarItemAccentColor
        tabBar.unselectedItemTintColor = UIColor.tabBarItemLight
    }
}
