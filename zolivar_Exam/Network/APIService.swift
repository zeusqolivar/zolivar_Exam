//
//  APIService.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/8/23.
//

import Foundation

class NetworkService {

    // Create a shared instance of NetworkService (Singleton)
    static let shared = NetworkService()

    private init() { }

    // Define a base URL for your API
    private let baseURL = "http://localhost:3001/v1"

    // Perform a POST request for login
    func login(mobile: String, mpin: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "/login"

        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Add parameters as needed (e.g., username and password)
        let parameters: [String: Any] = [
            "mobile": mobile,
            "mpin": mpin
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    // Perform a POST request for registration
    func register(mobile: String, mpin: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "/register"

        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Add parameters as needed (e.g., username and password)
        let parameters: [String: Any] = [
            "mobile": mobile,
            "mpin": mpin
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    func getUserProfile(mobile: String, mpin: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "/getUserProfile"

        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Add parameters as needed (e.g., username and password)
        let parameters: [String: Any] = [
            "mobile": mobile,
            "mpin": mpin
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    func getRewards(completion: @escaping (Result<Data, Error>) -> Void) {
        let endpoint = "/getrewards" // Update the endpoint to match your API

        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Use POST method for fetching rewards

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }
}

// Define custom error types for networking errors
enum NetworkError: Error {
    case invalidURL
    case noData
}
