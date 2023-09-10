//
//  mainPage.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/6/23.
//

import Foundation
import UIKit

class mainPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white // Set the background color of the view

        // Calculate the button size based on available space
        let buttonWidth = min(view.bounds.width - 40, 200) // Maximum width of 200, but not wider than the available space
        let buttonHeight: CGFloat = 50

        // Create Login Button
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0) // Set background color
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        // Set fixed size for the button
        loginButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

        // Create Register Button
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0) // Set background color
        registerButton.layer.cornerRadius = 10
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        // Set fixed size for the button
        registerButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

        // StackView to arrange buttons vertically
        let stackView = UIStackView(arrangedSubviews: [loginButton, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center

        // Add StackView to the main view
        view.addSubview(stackView)

        // Set constraints to center the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc func loginButtonTapped() {

        let vc = loginPage()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    @objc func registerButtonTapped() {
        let vc = registerPage()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

