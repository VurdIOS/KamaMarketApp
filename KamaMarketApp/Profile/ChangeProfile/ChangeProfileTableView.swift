//
//  ChangeProfileTableView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 04.12.2023.
//


import UIKit

class ChangeProfileTableView: UIView {
    
    private let array = ["Name", "Surname", "Nickname", "Birthday"]
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var user: UserInfo?
    
    init(frame: CGRect, user: UserInfo){
        super.init(frame: frame)
        tableView.register(ChangeProfileViewCell.self, forCellReuseIdentifier: "ChangeProfileViewCell")
        self.addSubview(tableView)
        self.user = user
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 60

        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.bounds
        //        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ChangeProfileTableView: UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeProfileViewCell", for: indexPath) as! ChangeProfileViewCell
        cell.textfield.delegate = self
        cell.textfield.tag = indexPath.row
        cell.textfield.placeholder = array[indexPath.row]
        //Тут разберись, расставляем по ячейкам то что имеем
        switch indexPath.row {
        case 0:
            cell.textfield.text = user?.firstName
        case 1:
            cell.textfield.text = user?.secondName
        default:
            break
        }

        
        return cell
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Тут разберись как информацию забирать отсюда красиво, некрасиво и так получается
        let index = NSIndexPath(row: textField.tag, section: 0) // Через этот индекс можно номер строки забирать
        if let cell = tableView.cellForRow(at: index as IndexPath) as? ChangeProfileViewCell {
            if textField == cell.textfield {
                cell.textfield.text = "234234"
            } else if textField == cell.textfield {
                
            }
        }
    }
    
}
extension ChangeProfileTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let model = models[indexPath.row]
//        model.handler()
    }
}




