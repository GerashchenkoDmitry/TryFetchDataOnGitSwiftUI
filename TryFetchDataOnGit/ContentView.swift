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
  
  @ObservableObject var item = RepositoryViewModel()
  
  @State private var searchText = ""
  @State private var showCancelButton: Bool = false
  
  @State private var items = [Item]()
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("search", text: $searchText, onEditingChanged: { isEditing in
              self.showCancelButton = true
            }, onCommit: {
              print("onCommit")
              self.loadData(description: searchText)
            }).foregroundColor(.primary)
            
            Button(action: {
              self.searchText = ""
            }) {
              Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
            }
          }
          .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
          .foregroundColor(.secondary)
          .background(Color(.secondarySystemBackground))
          .cornerRadius(10.0)
          
          if showCancelButton  {
            Button("Cancel") {
              UIApplication.shared.endEditing(true) // this must be placed before the other commands here
              self.searchText = ""
              self.showCancelButton = false
            }
            .foregroundColor(Color(.systemBlue))
          }
        }
        
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
        
        List(items, id: \.id) { item in
          NavigationLink(destination: DetailView(item: item)) {
            VStack(alignment: .leading) {
              Text(item.name ?? "Unknown name")
                .font(.headline)
              Text("language: \(item.language ?? "Unknown language")")
                .foregroundColor(.secondary)
              Text("Stars: \(item.stargazers_count ?? 0)")
              Text("Forks: \(item.forks_count ?? 1)")
              Text("License: \(item.license?.name ?? "Unknown license")")
            }
          }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Git Search")
      }
    }
    
  }
  
  func loadData(description: String) {
    guard let url = URL(string: "https://api.github.com/search/repositories?q=\(description.replacingOccurrences(of: " ", with: "+"))") else {
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

extension UIApplication {
  func endEditing(_ force: Bool) {
    self.windows
      .filter{$0.isKeyWindow}
      .first?
      .endEditing(force)
  }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
  var gesture = DragGesture().onChanged{_ in
    UIApplication.shared.endEditing(true)
  }
  func body(content: Content) -> some View {
    content.gesture(gesture)
  }
}

extension View {
  func resignKeyboardOnDragGesture() -> some View {
    return modifier(ResignKeyboardOnDragGesture())
  }
}
