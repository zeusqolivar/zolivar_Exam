//
//  registerPage.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/6/23.
//

import Foundation
import UIKit
import UIKit

class registerPage: UIViewController {

    // MARK: - Properties

    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let mobileNumberTextField = UITextField()
    let mpinTextField = UITextField()
    let confirmMpinTextField = UITextField()

    let backButton = UIButton()
    let registerButton = UIButton()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Set up the text fields
        setupTextField(firstNameTextField, placeholder: "First Name")
        setupTextField(lastNameTextField, placeholder: "Last Name")
        setupTextField(mobileNumberTextField, placeholder: "Mobile Number")
        setupTextField(mpinTextField, placeholder: "Mpin")
        setupTextField(confirmMpinTextField, placeholder: "Confirm Mpin")

        // Set up buttons with styling
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 10
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)

        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)

        // Add targets for button actions
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        // Create a stack view for horizontal arrangement
        let stackView = UIStackView(arrangedSubviews: [backButton, registerButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        // Create a container view for the text fields and buttons
        let containerView = UIView()
        containerView.addSubview(firstNameTextField)
        containerView.addSubview(lastNameTextField)
        containerView.addSubview(mobileNumberTextField)
        containerView.addSubview(mpinTextField)
        containerView.addSubview(confirmMpinTextField)
        containerView.addSubview(stackView)

        // Add constraints to position the elements
        containerView.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        mobileNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        mpinTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmMpinTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            mobileNumberTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            mobileNumberTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mobileNumberTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            mpinTextField.topAnchor.constraint(equalTo: mobileNumberTextField.bottomAnchor, constant: 10),
            mpinTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mpinTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            confirmMpinTextField.topAnchor.constraint(equalTo: mpinTextField.bottomAnchor, constant: 10),
            confirmMpinTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            confirmMpinTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            stackView.topAnchor.constraint(equalTo: confirmMpinTextField.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])

        // Add the container view to the main view
        view.addSubview(containerView)

        // Set up constraints for the container view
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    // MARK: - Button Actions

    @objc func backButtonTapped() {
        dismiss(animated: true , completion: nil)
    }

    @objc func registerButtonTapped() {

    }

    // MARK: - Helper Methods

    func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
}
