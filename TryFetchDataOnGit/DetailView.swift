//
//  DetailView.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 01.07.2021.
//

import SwiftUI

struct DetailView: View {
  
  @State var item: Item
  
    var body: some View {
      Form {
        Section {
          Text(item.name)
          Text(item.language ?? "Unknown")
          Text(item.description)
        }
      }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
      DetailView(item: Item(id: 20, name: "Repo name", description: "About repo", language: "Swift", stargazers_count: 12, forks_count: 3, license: License(name: "MIT License")))
    }
}
