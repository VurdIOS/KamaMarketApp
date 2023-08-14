//
//  AuthorizationViewController.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.08.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    
    var fallingAlert: UIView!
    
    
    lazy var logoView: UIImageView = {
        let logo = UIImageView()
        let viewWidth = view.frame.width - 100
        let viewHeight = viewWidth * 0.127
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    var logoImage: UIImage!
    
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
            string: "Пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.isSecureTextEntry = true
        
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no // прячет строку автокоррекции текста в клавиатуре
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
//        setupToolBarFor(textField: firstTF)
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemGray
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 22
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isEnabled = true
        
        
        return button
    }()
    
    var registrationButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.configuration = .plain()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    private var viewModel: AuthorizationViewModelProtocol! {
        didSet {
            logoImage = UIImage(named: viewModel.logoImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = AuthorizationViewModel()
        
        fallingAlert = FallingAlert(frame: CGRect(x: 0, y: 30, width: view.frame.width / 2, height: 60))
        
        setupLogo()
        setupConstraints()
        setupTargetsForButtons()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
    }
    
   
    
    func setupConstraints() {
        view.addSubview(logoView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registrationButton)
    
        
        
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
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
        

        NSLayoutConstraint.activate([
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            registrationButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            registrationButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func showWrongLoginAlert() {
       let alert = FallingAlert(frame: CGRect(x: 0, y: 50, width: view.frame.width,  height: 100 ))
        
        self.view.addSubview(alert)
        alert.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        alert.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        print("@#@3")
    }
    
    func setupLogo() {
        logoView.image = logoImage
        logoView.clipsToBounds = true
        
    }
    func setupTargetsForButtons() {
        loginButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }
    
    @objc func logInButtonPressed() {
        print("1")
        
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if viewModel.logInWith(name: login, password: password) {
            print("3")
            view.backgroundColor = .red
        } else {
            showWrongLoginAlert()
            loginTextField.text = ""
            passwordTextField.text = ""
        }
    }
}



extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.gray.cgColor
       
        borderStyle = .none
        layer.addSublayer(bottomLine)
        bottomLine.masksToBounds = true
    }
}

extension AuthorizationViewController {
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let gotItAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.dismiss(animated: true)
        }
        alert.addAction(gotItAction)
        present(alert, animated: true)
    }
}

