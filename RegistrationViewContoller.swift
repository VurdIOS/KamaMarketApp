//
//  RegistrationViewContoller.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 23.08.2023.
//

import UIKit

class RegistrationViewContoller: UIViewController {
    
    
    var fallingAlert: UIView!
    
    var yourBackImage = UIImage(named: "backButton")
    
    
    lazy var logoView: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "Logo"))
        let viewWidth = view.frame.width - 100
        let viewHeight = viewWidth * 0.127
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    var loginTextField: UITextField = {
        let tf = UITextField()
        tf.clearButtonMode = .always
        tf.textColor = .black
        tf.textAlignment = .left
        tf.attributedPlaceholder = NSAttributedString(
            string: "Имя пользвателя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no // прячет строку автокоррекции текста в клавиатуре
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.textAlignment = .left
        tf.attributedPlaceholder = NSAttributedString(
            string: "Почта",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.isSecureTextEntry = true
        
//        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no // прячет строку автокоррекции текста в клавиатуре
        
        tf.translatesAutoresizingMaskIntoConstraints = false
    
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemGray
        button.setTitle("Далее", for: .normal)
        button.layer.cornerRadius = 22
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = false
        
        
        return button
    }()
    
    
//    private var viewModel: AuthorizationViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        viewModel = AuthorizationViewModel()
        


        
        setupNavBar()
        setupConstraints()
        setupTargetsForButtons()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginTextField.addBottomBorder(color: .gray)
        passwordTextField.addBottomBorder(color: .gray)
    }
    
    private func setupNavBar() {
        self.title = "Регистрация"
        let backImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popnav))
    }

    @objc func popnav() {
    self.navigationController?.popViewController(animated: true)
}
    func setupConstraints() {
        view.addSubview(logoView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            logoView.widthAnchor.constraint(equalToConstant: 130),
            logoView.heightAnchor .constraint(equalToConstant: 113)
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            loginTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    func showWrongLoginAlert() {
        let alert = FallingAlert(frame: CGRect(x: 28, y: 56, width: view.frame.width - 56,  height: 60))
        
        self.view.addSubview(alert)
    }
    
    func setupTargetsForButtons() {
        loginTextField.addTarget(self, action: #selector(textFieldValueFilled), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldValueFilled), for: .editingChanged)
//        loginButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }
    
//    @objc func logInButtonPressed() {
//        guard let login = loginTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//    }
    
    @objc func textFieldValueFilled() {
        if loginTextField.text != "", passwordTextField.text != "" {
            loginButton.enable()
        } else {
            loginButton.disable()
        }
    }
//
//    private func enteredWrongPasswordOrName() {
//        showWrongLoginAlert()
//        loginTextField.text = ""
//        passwordTextField.text = ""
//        loginTextField.addBottomBorder(color: .red)
//        passwordTextField.addBottomBorder(color: .red)
//        loginTextField.attributedPlaceholder = NSAttributedString(
//            string: "Имя пользвателя",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//        passwordTextField.attributedPlaceholder = NSAttributedString(
//            string: "Пароль",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//        loginButton.disable()
//    }
}
