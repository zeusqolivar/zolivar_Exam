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
    var userViewModel:userPageViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    func setupUI() {
        view.backgroundColor = .white
        mobileNumberTextField.placeholder = "Mobile Number (11 digits)"
        mobileNumberTextField.borderStyle = .roundedRect
        mobileNumberTextField.keyboardType = .numberPad
        mpinTextField.placeholder = "MPIN (4 digits)"
        mpinTextField.borderStyle = .roundedRect
        mpinTextField.keyboardType = .numberPad
        mpinTextField.isSecureTextEntry = true
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.backgroundColor = UIColor(red: 0.12, green: 0.53, blue: 0.90, alpha: 1.0)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 10
        let textFieldStackView = UIStackView(arrangedSubviews: [mobileNumberTextField, mpinTextField])
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 20
        textFieldStackView.alignment = .fill
        let buttonStackView = UIStackView(arrangedSubviews: [backButton, loginButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually
        let stackView = UIStackView(arrangedSubviews: [textFieldStackView, buttonStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .fill
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

    }
    @objc func loginButtonTapped() {

        guard var mobileNumber = mobileNumberTextField.text else {
            return

        }

        if !mobileNumber.isEmpty {
            mobileNumber.removeFirst()
        }
        
        guard let mpin = mpinTextField.text else {
            return
        }

        loginViewModel.login(mobile:mobileNumber, mpin: mpin) { result in
            switch result {
            case .success(let data):
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
                        DispatchQueue.main.async {
                            self.showAlert(title: "Error", message: loginResponse.message)
                        }
                    default: print("Unhandled Status Code")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }



            case .failure(let error):
                print("Login failed with error: \(error)")
            }
        }
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}




