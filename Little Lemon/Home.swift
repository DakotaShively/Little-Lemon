//
//  Home.swift
//  Little Lemon
//
//  Created by Dakota Shively on 7/17/23.
//

import SwiftUI
import Foundation
import CoreData


struct Home: View {
    
    
    var body: some View {
        let persistance = PersistenceController.shared
        TabView{
            UserProfile()
                .tabItem{
                    Label("Profile", systemImage: "square.and.pencil")
                }
                .navigationBarBackButtonHidden(true)
            Menu()
                
                .tabItem{
                    Label("Menu", systemImage: "list.dash")
                }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
