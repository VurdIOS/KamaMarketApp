//
//  ChangeProfileView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 03.12.2023.
//

import UIKit

class ChangeProfileView: UIViewController {
    
    let profileIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "UserIcon"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let nameLabel: UIButton = {
        let btn = UIButton()
        btn.setTitle("Выбрать фотографию", for: .normal)
        btn.configuration = .plain()
        btn.setTitleColor(.AccentColor, for: .normal)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite
        setupNavBar()
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    private func setupNavBar() {
        let cancelImage = UIImage(named: "CancelButton")?.withRenderingMode(.alwaysOriginal)
        let finishChanges = UIImage(named: "FinishButton")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: cancelImage, style: .plain, target: self, action: #selector(popnav))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: finishChanges, style: .plain, target: self, action: #selector(finishChange))
    }
    
    private func setupConstraints() {
        view.addSubview(profileIcon)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            profileIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            profileIcon.widthAnchor.constraint(equalToConstant: 80),
            profileIcon.heightAnchor .constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func popnav() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func finishChange() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
