//
//  Menu.swift
//  Little Lemon
//
//  Created by Dakota Shively on 7/17/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon")
                .font(.title)
                .padding()
            Text("Location")
                .font(.headline)
                .padding()
            Text("Description")
                .multilineTextAlignment(.center)
                .padding()
            
            List{}
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
