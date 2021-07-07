//
//  GitAPI.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 06.07.2021.
//

import Foundation
import Combine

class GitAPI {
  static let shared = GitAPI()
  
  private let baseURL = "https://api.github.com/search/repositories"
  
  private func absoluteURL(repository: String) -> URL? {
    
    let queryURL = URL(string: baseURL)!
    let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
    guard var urlComponents = components else { return nil }
    urlComponents.queryItems = [URLQueryItem(name: "q", value: repository)]
    
    return urlComponents.url
  }
  
  func fetchRepositories(for repository: String) -> AnyPublisher<Item, Never> {
    guard let url = absoluteURL(repository: repository) else {                  
        return Just(Item.placeholder)
            .eraseToAnyPublisher()
    }
    
    return
      URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: Item.self, decoder: JSONDecoder())
      .catch { error in Just(Item.placeholder)}
      .receive(on: RunLoop.main)                                
      .eraseToAnyPublisher()
  }
//  func loadData(description: String) {
//    guard let url = URL(string: "https://api.github.com/search/repositories?q=\(description.replacingOccurrences(of: " ", with: "+"))") else {
//      print("Invalid URL")
//      return
//    }
//
//    let request = URLRequest(url: url)
//
//    URLSession.shared.dataTask(with: request) { data, response, error in
//      if let data = data {
//        if let results = try? JSONDecoder().decode(Response.self, from: data) {
//          DispatchQueue.main.async {
//            self.items = results.items
//          }
//          return
//        }
//      }
//      print("Error: \(error?.localizedDescription ?? "Unknown error")")
//    }
//    .resume()
//  }
}
