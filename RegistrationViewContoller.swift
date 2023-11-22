//
//  RegistrationViewContoller.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 23.08.2023.
//

import UIKit

class RegistrationViewContoller: UIViewController {
    
    var viewModel: RegistrationViewModelProtocol!
    
    var fallingAlert: UIView!
    
    var yourBackImage = UIImage(named: "backButton")
    
    
    lazy var logoView: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "Logo"))
        let viewWidth = view.frame.width - 100
        let viewHeight = viewWidth * 0.127
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    var nameTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
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
    
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.textColor = .black
        tf.textAlignment = .left
        tf.attributedPlaceholder = NSAttributedString(
            string: "Почта",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.autocorrectionType = .no
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = RegistrationViewModel()
        setupKeyboardHiding()
        
        setupNavBar()
        setupConstraints()
        setupTargetsForButtons()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.addBottomBorder(color: .gray)
        emailTextField.addBottomBorder(color: .gray)
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
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(loginButton)
    
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            logoView.widthAnchor.constraint(equalToConstant: 130),
            logoView.heightAnchor .constraint(equalToConstant: 113)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    // Попробовать сделать через делегат текстфилда
    func setupTargetsForButtons() {
        nameTextField.addTarget(self, action: #selector(textFieldValueFilled), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldValueFilled), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }
    
    @objc func logInButtonPressed() {
        let vc = RegistrationPasswordViewController()
        vc.viewModel = RegistrationPasswordViewModel(userName: nameTextField.text!, userEmail: emailTextField.text!)
        navigationController?.pushViewController(vc, animated: true)
//        FireBaseDataManager.shared.sendUserInfoToFireBase(user: UserInfo(firstName: nameTextField.text!))
    }
    
    @objc func textFieldValueFilled() {
        if nameTextField.text != "", emailTextField.text != "" {
            loginButton.enable()
        } else {
            loginButton.disable()
        }
    }
}
