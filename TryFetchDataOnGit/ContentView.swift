import SwiftUI

/*
 - название репозитория
 - описание
 - язык программирования
 - количество звезд
 - количество форков
 - информация о лицензии
 */

struct ContentView: View {
  
  @State private var items = [Item]()
  
  var body: some View {
    NavigationView {
    List(items, id: \.id) { item in
      NavigationLink(destination: DetailView(item: item)) {
        VStack(alignment: .leading) {
          Text(item.name)
            .font(.headline)
          Text("language: \(item.language ?? "Unknown language")")
            .foregroundColor(.secondary)
          Text("Stars: \(item.stargazers_count ?? 0)")
          Text("Forks: \(item.forks_count ?? 1)")
          Text("License: \(item.license?.name ?? "Unknown license")")
        }
      }
    }
    .onAppear {
      loadData()
    }
    .navigationTitle("Git Search")
    }
    
  }
  func loadData() {
    guard let url = URL(string: "https://api.github.com/search/repositories?q=Star+Wars") else {
      print("Invalid URL")
      return
    }
    
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let results = try? JSONDecoder().decode(Response.self, from: data) {
          DispatchQueue.main.async {
            self.items = results.items
          }
          return
        }
      }
      print("Error: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
