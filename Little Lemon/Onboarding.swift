//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Dakota Shively on 7/17/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email name key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var email:String = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(
                    destination: Home(),
                    isActive: $isLoggedIn)
                { EmptyView()}
                
                TextField("First name",text:$firstName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                TextField("Last name",text:$lastName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                TextField("Email",text:$email)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                Button("Submit", action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        if isValidEmail(email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                        isLoggedIn = true
                        }
                        else {
                            print("Email is not valid")
                        }
                    } else {
                        print("Please submit in all fields")
                    }
                    }) .padding()
            } .navigationTitle("Login Page")
            
                       }
        }
    }

    
    func isValidEmail(_ email: String) -> Bool {
                let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
                return emailPredicate.evaluate(with: email)
            }
        
    
    struct Onboarding_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding()
        }
    }
