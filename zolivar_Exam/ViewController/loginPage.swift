//
//  loginPage.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/6/23.
//

import Foundation
import UIKit

class loginPage: UIViewController {

    var mobileNumberTextField = UITextField()
    var mpinTextField = UITextField()
    var loginButton = UIButton()
    var backButton =  UIButton()

    let loginViewModel = loginPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    func setupUI() {
        view.backgroundColor = .white
        // Create Mobile Number Text Field
        mobileNumberTextField.placeholder = "Mobile Number (11 digits)"
        mobileNumberTextField.borderStyle = .roundedRect
        mobileNumberTextField.keyboardType = .numberPad
        // Create MPIN Text Field
        mpinTextField.placeholder = "MPIN (4 digits)"
        mpinTextField.borderStyle = .roundedRect
        mpinTextField.keyboardType = .numberPad
        mpinTextField.isSecureTextEntry = true
        // Create Login Button
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        // Create Back Button
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 10
        // StackView to arrange Mobile Number and MPIN text fields vertically
        let textFieldStackView = UIStackView(arrangedSubviews: [mobileNumberTextField, mpinTextField])
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 20
        textFieldStackView.alignment = .fill
        // Horizontal StackView to arrange Login and Back buttons
        let buttonStackView = UIStackView(arrangedSubviews: [backButton, loginButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually


        // StackView to arrange text fields and buttons vertically
        let stackView = UIStackView(arrangedSubviews: [textFieldStackView, buttonStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .fill

        // Add StackView to the main view
        view.addSubview(stackView)

        // Set constraints to center the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

    }
    @objc func loginButtonTapped() {

        guard let mobileNumber = mobileNumberTextField.text else {
            return
        }
        guard let mpin = mpinTextField.text else {
            return
        }

        loginViewModel.login(mobile:"9123456789", mpin: "1234") { result in
            switch result {
            case .success(let data):
                // Handle login success (parse data, update UI, etc.)
                print("Login success. Data received: \(data)")
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                    switch loginResponse.status{
                    case 200:
                        if let status = loginResponse.status{
                            print("Status Good")
                        }
                        DispatchQueue.main.async {
                            let vc = userPage()
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true,completion: nil)
                        }
                    case 404:
                        print("404 Not Found")
                    default: print("Unhandled Status Code")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }



            case .failure(let error):
                // Handle login failure (show alert, log error, etc.)
                print("Login failed with error: \(error)")
            }
        }
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}




