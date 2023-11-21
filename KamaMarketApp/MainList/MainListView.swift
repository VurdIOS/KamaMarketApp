//
//  MainViewTB.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import UIKit

class MainListView: UIViewController {
    
    let firstButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Box", for: .normal)
        btn.backgroundColor = .brown
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        
        return btn
    }()
    
    let secondButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Tshirt", for: .normal)
        btn.backgroundColor = .brown
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupConstrainth()
        setupTargets()

        // Do any additional setup after loading the view.
    }
    
    func setupConstrainth() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        
        
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 50)
        ])
    }
    
    func setupTargets() {
        firstButton.addTarget(self, action: #selector(firtsButtonTapped), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
    }
    
    @objc func firtsButtonTapped() {
        // Используя эти функции можно сразу на сервак отправить и заменить также значения по этому ключу
        let user = FireBaseDataManager.shared.returee(something: UserInfo(firstName: "Kamal", secondName: "Atavaliev", nickName: "Kama", birthday: "07011996", phoneNumber: "+7912345123", email: "kamalios@mail.ru"))
        FireBaseDataManager.shared.databaseUserInfoPath?.child("userInfo").setValue(user)

    }
    
    @objc func secondButtonTapped() {
        FireBaseDataManager.shared.inCartTapped(staffID: inCartModel(text: "Tshirt"))
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
