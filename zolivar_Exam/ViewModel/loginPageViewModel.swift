//
//  LoginViewModel.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/8/23.
//

import Foundation

class loginPageViewModel {

    private let networkService: NetworkService
    

    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }

    func login(mobile: String, mpin: String, completion: @escaping (Result<Data, Error>) -> Void) {
        networkService.login(mobile: mobile, mpin: mpin, completion: completion)
        
    }
}
