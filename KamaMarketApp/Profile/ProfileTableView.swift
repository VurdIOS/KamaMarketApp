//
//  ProfileTableView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 26.11.2023.
//

import UIKit

class ProfileTableView: UIView {
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var models: [ProfileCellModel]!
    
    init(frame: CGRect, models: [ProfileCellModel]){
        super.init(frame: frame)
        self.addSubview(tableView)
        self.models = models
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.bounds
//        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
//    func configure() {
//        models = [
//            ProfileCellModel(icon: "ProfileLiked", name: "Понравившиеся", handler: {
//
//            }),
//            ProfileCellModel(icon: "ProfileStaff", name: "Мои товары", handler: {
//
//            })
//        ]
//    }
}

extension ProfileTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = model.name
        content.image = UIImage(named: model.icon)
        
        

        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
}

extension ProfileTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        model.handler()
    }
}
