//
//  RepositoryViewModel.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 06.07.2021.
//

import Foundation
import Combine

final class RepositoryViewModel: ObservableObject {
  
  @Published var name: String = ""
  
  @Published var currentRepo = Item.placeholder
//  @Published var language: String
//  @Published var stargazers_count: Int
//  @Published var forks_count: Int
  
  init() {
    $name
      .removeDuplicates()
      .flatMap { (repository: String) -> AnyPublisher<Item, Never> in
        GitAPI.shared.fetchRepositories(for: self.name)
      }
      .assign(to: \.currentRepo , on: self)
      .store(in: &self.cancellable)
  }
  
  private var cancellable: Set<AnyCancellable> = []
}
