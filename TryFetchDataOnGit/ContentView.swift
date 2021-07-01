import SwiftUI

struct Response: Codable {
  var items: [Result]
}

struct Result: Codable {
  var id: Int
  var name: String
//  var collectionName: String
}

struct ContentView: View {
  
  @State private var results = [Result]()
  
  var body: some View {
    List(results, id: \.id) { item in
      VStack(alignment: .leading) {
        Text(item.name)
          .font(.headline)
//        Text(item.collectionName)
//          .foregroundColor(.secondary)
      }
    }
    .onAppear {
      loadData()
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
            self.results = results.items
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
