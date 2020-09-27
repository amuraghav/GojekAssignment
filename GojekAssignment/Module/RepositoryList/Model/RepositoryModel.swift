//
//  RepositoryModel.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import Foundation
struct Repository: Codable {
    let author, name: String?
    let avatar: String?
    let url: String?
    let welcomeDescription, language, languageColor: String?
    let stars, forks, currentPeriodStars: Int?
    let builtBy: [BuiltBy]?
    
    enum CodingKeys: String, CodingKey {
           case author, name, avatar, url
           case welcomeDescription = "description"
           case language, languageColor, stars, forks, currentPeriodStars, builtBy
       }
}

// MARK: - BuiltBy
struct BuiltBy: Codable {
    let username: String
    let href, avatar: String
}
