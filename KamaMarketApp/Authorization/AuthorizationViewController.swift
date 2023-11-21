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
        let logo = UIImageView(image: UIImage(named: "Logo"))
        let viewWidth = view.frame.width - 100
        let viewHeight = viewWidth * 0.127
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.text = "kamalios@mail.ru"
        tf.autocapitalizationType = .none
        tf.clearButtonMode = .always
        tf.textColor = .black
        tf.textAlignment = .left
        tf.attributedPlaceholder = NSAttributedString(
            string: "Почта",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no // прячет строку автокоррекции текста в клавиатуре
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.text = "123456"
        tf.autocapitalizationType = .none
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
    
    private var viewModel: AuthorizationViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserAction.like.rawValue)
        
        
        view.backgroundColor = .white
        viewModel = AuthorizationViewModel()
        
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        
        setupConstraints()
        setupTargetsForButtons()
        setupKeyboardHiding()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.addBottomBorder(color: .gray)
        passwordTextField.addBottomBorder(color: .gray)
    }
    
   
    
    func setupConstraints() {
        view.addSubview(logoView)
        view.addSubview(emailTextField)
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
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
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
        let alert = FallingAlert(frame: CGRect(x: 28, y: 56, width: view.frame.width - 56,  height: 60))
        
        self.view.addSubview(alert)
    }
    
    func setupTargetsForButtons() {
        emailTextField.addTarget(self, action: #selector(textFieldValueFilled), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldValueFilled), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
    }
    
    @objc func registrationButtonPressed() {
        let vc = RegistrationViewContoller()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logInButtonPressed() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        viewModel.userEmail = email
        viewModel.password = password
        
        viewModel.singIn { [self] result in
            switch result {
            case.success(_):
                let vc = MainTabBarView()
                navigationController?.pushViewController(vc, animated: true)
            case.failure(let error):
                print(error)
                enteredWrongPasswordOrName()
            }
        }
    }
    
    @objc func textFieldValueFilled() {
        if emailTextField.text != "", passwordTextField.text != "" {
            loginButton.enable()
        } else {
            loginButton.disable()
        }
    }
    
    private func enteredWrongPasswordOrName() {
        showWrongLoginAlert()
        emailTextField.text = ""
        passwordTextField.text = ""
        emailTextField.addBottomBorder(color: .red)
        passwordTextField.addBottomBorder(color: .red)
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Имя пользвателя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        loginButton.disable()
    }
}

extension UITextField {
    func addBottomBorder(color: UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
        bottomLine.backgroundColor = color.cgColor
       
        borderStyle = .none
        layer.addSublayer(bottomLine)
        bottomLine.masksToBounds = true
    }
}

extension UIButton {
    func disable() {
        self.isEnabled = false
        self.backgroundColor = .systemGray
    }
    
    func enable() {
        self.isEnabled = true
        self.backgroundColor = .systemBlue
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

extension UIViewController {
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector (keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            view.frame.origin.y = view.frame.origin.y - 100
        }
        
    }
    
    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }
}
