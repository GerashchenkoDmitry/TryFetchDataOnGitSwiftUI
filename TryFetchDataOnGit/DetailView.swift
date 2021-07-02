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
    GeometryReader { geometry in
      VStack(alignment: .center, spacing: 10) {
        RemoteImage(url: item.owner.avatar_url)
          .aspectRatio(contentMode: .fit)
          .foregroundColor(.gray)
          .clipShape(Circle())
          .frame(width: geometry.size.width, height: 200)
          
          
        Text(item.owner.login)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Repository name: \(item.name)")
            .font(.headline)
          Text("Language: \(item.language ?? "Unknown")")
          
          Text("Description: \(item.description)")
            .navigationTitle(item.name)
        }
        .padding(10)
      }
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(item: Item(id: 20, name: "Repo name",owner: Owner(id: Int(arc4random()), login: "Owner login", avatar_url: "person", type: "public"), description: "About repo", language: "Swift", stargazers_count: 12, forks_count: 3, license: License(name: "MIT License")))
  }
}
