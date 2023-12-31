//
//  RegistrationPasswordViewController.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 04.10.2023.
//

import UIKit

class RegistrationPasswordViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: RegistrationPasswordViewModelProtocol!
    
    lazy var lockImageView: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "LockImage"))
        let viewWidth = 80
        let viewHeight = 80
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Придумайте пароль"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Минимальная длина — 8 символов. Для надежности пароль должен содержать буквы и цифры."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.defaultTextAttributes.updateValue(14, forKey: NSAttributedString.Key.kern)
        tf.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        tf.returnKeyType = .next
        tf.isSecureTextEntry = true
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordRepeatTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.borderStyle = .none
        tf.textAlignment = .center
        tf.defaultTextAttributes.updateValue(14, forKey: NSAttributedString.Key.kern)
        tf.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        tf.returnKeyType = .done
        tf.isSecureTextEntry = true
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print(viewModel.userName)
        print(viewModel.userEmail)
        
        
        passwordTextField.delegate = self
        passwordRepeatTextField.delegate = self
        
        setupNavBar()
        setupConstraints()
        setupTargetsForButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let maxLength = 8
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return newString.count <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField, textField.text != "" {
            passwordRepeatTextField.becomeFirstResponder()
        } else {
            passwordRepeatTextField.resignFirstResponder()
            confirmPassword()
        }
        return true
    }
    
    private func setupNavBar() {
        self.title = "Регистрация"
        let backImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
        let eyeSwitcher = UIImage(named: "EyeSwitcher")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popnav))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: eyeSwitcher, style: .plain, target: self, action: #selector(showPassword))
    }
    
    @objc func popnav() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordRepeatTextField.isSecureTextEntry.toggle()
    }
    
    func setupConstraints() {
        
        view.addSubview(lockImageView)
        view.addSubview(titleLabel)
        view.addSubview(discriptionLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordRepeatTextField)
        
        NSLayoutConstraint.activate([
            lockImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lockImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: lockImageView.bottomAnchor, constant: 30)
            
        ])
        
        NSLayoutConstraint.activate([
            discriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            discriptionLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 30)
            
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: 28),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 156),
            passwordTextField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            passwordRepeatTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordRepeatTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            passwordRepeatTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 156),
            passwordRepeatTextField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
    }
    
    func setupTargetsForButtons() {
        
    }
    
    func confirmPassword() {
        if passwordTextField.text == passwordRepeatTextField.text {
            viewModel.password = passwordTextField.text
            print("Password Confirm")
            viewModel.createNewUser { [self] result in
                switch result {
                case.success(_):
                    print("success")
                    let vc = MainTabBarView()
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true)
                case.failure(let error):
                    print(error)
                    print("suka")
                }
            }
        } else {
            passwordTextField.textColor = .red
            passwordRepeatTextField.textColor = .red
            print("asdasd")
        }
    }
}
