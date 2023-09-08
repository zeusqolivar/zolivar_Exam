//
//  User.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/9/23.
//

import Foundation

struct User: Codable {
    let id: String?
    let first_name: String?
    let last_name: String?
    let mobile: String?
}
struct UserProfile: Codable{
    let id: String?
    let first_name: String?
    let last_name: String?
    let mobile: String?
    let is_verified:Bool?
    let referral_code:String?
}

struct UserData: Codable {
    let user: User?
}

struct LoginResponse: Codable {
    let status: Int?
    let message: String?
    let data: UserData?
}
