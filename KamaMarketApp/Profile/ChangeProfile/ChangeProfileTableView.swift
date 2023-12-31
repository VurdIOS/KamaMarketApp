//
//  ChangeProfileTableView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 04.12.2023.
//


import UIKit

enum ProfileTextFields: String, CaseIterable {
    case name = "Имя"
    case surname = "Фамиля"
    case nickName = "Псевдоним"
    case birthday = "День рождения"
    case phoneNumber = "Телефон"
    case email = "Эл. почта"
}

class ChangeProfileTableView: UIView {

    let firstTable = ["Имя", "Фамиля", "Псевдоним", "День рождения"]
    let secondTable = ["Телефон", "Эл. почта"]
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var user: UserInfo? {
        didSet {
            print(user?.firstName)
            print(user?.secondName)
            print(user?.nickName)
            print(user?.birthday)
            print(user?.phoneNumber)
            print(user?.email)
        }
    }
    
    init(frame: CGRect, user: UserInfo){
        super.init(frame: frame)
        tableView.register(ChangeProfileViewCell.self, forCellReuseIdentifier: "ChangeProfileViewCell")
        self.addSubview(tableView)
        self.user = user
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 45
        tableView.sectionHeaderHeight = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.frame = self.bounds
        //        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ChangeProfileTableView: UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeProfileViewCell", for: indexPath) as! ChangeProfileViewCell
        cell.textfield.delegate = self
        cell.textfield.tag = indexPath.row
        cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        cell.textfield.placeholder = indexPath.section == 0 ? textFieldsPlaceHolders[0...2][indexPath.row] : textFieldsPlaceHolders[indexPath.row]
        cell.textfield.placeholder = indexPath.section == 0 ? firstTable[indexPath.row] : secondTable[indexPath.row]
        //Тут разберись, расставляем по ячейкам то что имеем
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.textfield.text = user?.firstName
            case 1:
                cell.textfield.text = user?.secondName
            case 2:
                cell.textfield.text = user?.nickName
            case 3:
                cell.textfield.text = user?.birthday
            default:
                break
            }
        } else {
            switch indexPath.row {
            case 0:
                cell.textfield.text = user?.phoneNumber
            case 1:
                cell.textfield.text = user?.email
            default:
                break
            }
        }
        return cell
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.placeholder {
        case ProfileTextFields.name.rawValue:
            user?.firstName = textField.text
        case ProfileTextFields.surname.rawValue:
            user?.secondName = textField.text
        case ProfileTextFields.nickName.rawValue:
            user?.nickName = textField.text
        case ProfileTextFields.birthday.rawValue:
            user?.birthday = textField.text
        case ProfileTextFields.phoneNumber.rawValue:
            user?.phoneNumber = textField.text
        case ProfileTextFields.email.rawValue:
            user?.email = textField.text
        default:
            break
        }
    }
}





