//
//  User.swift
//  GitHubFollowers
//
//  Created by Ahmad Ayman Mansour on 11/05/2023.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String  //avatar_url
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int   //public_repos
    var publicGists: Int   //public_gists
    var htmlUrl: String    //html_url
    var following: Int
    var followers: Int
    var createdAt: String   //created_at
}
