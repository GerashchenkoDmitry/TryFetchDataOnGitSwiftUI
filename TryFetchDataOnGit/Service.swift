//
//  Service.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 30.06.2021.
//

import Foundation

struct Response: Codable {
  var items: [Item]
}

struct Item: Codable {
  var id: Int
  var name: String
  var owner: Owner
  var description: String
  var language: String?
  var stargazers_count: Int?
  var forks_count: Int?
  var license: License?
}

struct License: Codable {
  var name: String?
  var url: String?
}

struct Owner: Codable {
  var id: Int
  var login: String
  var avatar_url: String
  var type: String?
}
