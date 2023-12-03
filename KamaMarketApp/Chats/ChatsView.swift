//
//  ChatsView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import UIKit

class ChatsView: UIViewController {
    var incartstring: String! {
        didSet {
            incart?.append(incartstring)
            cartLabels.text! += " \(incartstring!)"
        }
    }
    
    var incart: [String]?
    
    let cartLabels: UILabel = {
       let lbl = UILabel()
        lbl.text = "tut"
        lbl.textColor = .red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cartLabels)
        view.backgroundColor = .systemGray5
        cartLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cartLabels.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cartLabels.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        cartFetch()
//        fetchUser()
        
        }
    
//    func fetchUser() {
//        FireBaseDataManager.shared.userInfoListen { result in
//            switch result {
//            case .success(let user):
//                self.cartLabels.text = user.firstName
//            case .failure(let error):
//                print("blyaaaa error \(error)")
//            }
//        }
//    }
//
    func cartFetch() {
        FireBaseDataManager.shared.inCartListen { result in
            switch result {
            case .success(let model):
                self.cartLabels.text = model.text[1]

            case .failure(let error):
                print("asdasdas \(error.localizedDescription)")
            }
        }
    }
    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
