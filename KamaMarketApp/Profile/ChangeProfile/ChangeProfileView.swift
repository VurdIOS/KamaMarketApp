//
//  ChangeProfileView.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 03.12.2023.
//

import UIKit

class ChangeProfileView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func setupNavBar() {
        self.title = "Регистрация"
        let cancelImage = UIImage(named: "CancelButton")?.withRenderingMode(.alwaysOriginal)
        let finishChanges = UIImage(named: "FinishButton")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: cancelImage, style: .plain, target: self, action: #selector(popnav))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: finishChanges, style: .plain, target: self, action: #selector(finishChange))
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
