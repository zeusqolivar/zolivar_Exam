//
//  userPageViewModel.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/9/23.
//

import Foundation

class userPageViewModel {


    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }

    func getUserProfile(mobile: String, mpin: String, completion: @escaping (Result<Data, Error>) -> Void) {
        networkService.login(mobile: mobile, mpin: mpin, completion: completion)
    }
    func getRewards(completion: @escaping (Result<Data, Error>) -> Void) {
        networkService.getRewards(completion: completion)
    }

}
