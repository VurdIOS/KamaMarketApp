//
//  ChatsView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import UIKit

class ChatsView: UIViewController {
    let cartLabels: UILabel = {
       let lbl = UILabel()
        lbl.text = "tut"
        lbl.textColor = .red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cartLabels)
        view.backgroundColor = .systemGray5
        cartLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cartLabels.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        FireBaseDataManager.shared.inCartListen { model in
            let i = [String]
            for gg in model.text {
                i.self.append(gg)
            }
            
        }
        print("ONO TTUUUUUT\(FireBaseDataManager.shared.inCart)")
        

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

}
