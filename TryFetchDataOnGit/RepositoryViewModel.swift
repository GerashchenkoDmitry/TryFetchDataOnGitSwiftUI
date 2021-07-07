//
//  RepositoryViewModel.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 06.07.2021.
//

import SwiftUI
import Combine

final class RepositoryViewModel: ObservableObject {
  
  @Published var name: String = ""
}
