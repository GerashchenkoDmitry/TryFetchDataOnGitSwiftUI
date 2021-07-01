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
