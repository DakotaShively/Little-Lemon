import Foundation
import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Dish.entity(), sortDescriptors: []) var dishes: FetchedResults<Dish>
    
    func getMenuData() {
        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        guard let url = URL(string: serverURLString) else {
            print("Invalid server URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Parse the data into models using JSONDecoder
            do {
                let menuList = try JSONDecoder().decode(MenuList.self, from: data)
                let context = PersistenceController.shared.container.viewContext
                
                // Clear the database before saving new data
                PersistenceController.shared.clear()
                
                for menuItem in menuList.menu {
                    let dish = Dish(context: context)
                    dish.title = menuItem.title
                    dish.image = menuItem.image
                    dish.price = menuItem.price
                }
                
                try context.save()
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()}
    
    var body: some View {
        VStack {
            List(dishes) { dish in
                HStack {
                    Text("The dish, \(dish.title ?? "Title") is created")
                    AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        default:
                            ProgressView()
                        }
                    }
                    .frame(width: 50, height: 50)
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
}



struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
