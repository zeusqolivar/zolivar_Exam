//
//  UserProfile.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/9/23.
//

import Foundation

struct RewardItem: Codable {
    let id: Int
    let name: String
    var description: String
    let image: String
}

struct DataList: Codable {
    let list: [RewardItem]
}

struct ApiResponse: Codable {
    let status: Int?
    let message: String?
    let data: DataList
}
