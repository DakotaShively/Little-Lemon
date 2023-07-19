import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: buildSortDescriptors()) var dishes: FetchedResults<Dish>
    
    @State private var dataFetched = false
    @State private var searchText = ""
    
    static func buildSortDescriptors() -> [NSSortDescriptor] {
        
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    
    var body: some View {
        VStack {
            TextField("Search menu", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: searchText) { newValue in
                    // Perform search logic here (if needed)
                }
            
            Text("VStack works")
            
            
            if dataFetched {
                Text("2")
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            if let title = dish.title, let price = dish.price, let image = dish.image {
                                Text("\(title) - \(price) - \(image)")
                            } else {
                                Text("No title or price available")
                            }
                        }
                    }
                }
            } else {
                Text("Fetch Isn't Working")
            }
        }
        .onAppear {
            if !dataFetched {
                getMenuData()
            }
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let serverURL = URL(string: serverURLString)!
        
        let urlRequest = URLRequest(url: serverURL)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(MenuList.self, from: data)
                        let menuItems = decodedData.menu
                        
                        for item in menuItems {
                            let dish = Dish(context: viewContext)
                            dish.title = item.title
                            dish.image = item.image
                            dish.price = item.price
                        }
                        
                        try? viewContext.save()
                        dataFetched = true
                        print("Data fetched and saved successfully.")
                    } catch {
                        print("Error decoding the response data: \(error)")
                    }
                } else if let error = error {
                    print("Error: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
