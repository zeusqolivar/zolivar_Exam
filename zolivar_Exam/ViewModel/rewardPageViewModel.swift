//
//  rewardPageViewModel.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/12/23.
//

import Foundation

class rewardPageViewModel{
    var imageURL: String
    var name: String
    var description: String

        // Initialize the ViewModel with data
        init(imageURL: String, name: String, description: String) {
            self.imageURL = imageURL
            self.name = name
            self.description = description
        }
}
