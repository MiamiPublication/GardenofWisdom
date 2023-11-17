//
//  RegisterView.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2023-11-26.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var registrationSuccess: Bool = false
    
    //Navigate to the LoginView when the registration is successful
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                    .padding(.bottom, 30)
                
                TextField("Email", text: $email )
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                Button(action: {
                    register()
                }){
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                NavigationLink(destination: ContentView()){
                    
                }
                Spacer()
 
                    
            }
            .padding()
            .background(Color.teal)
            .onChange(of: registrationSuccess, perform: { value in
                if value {
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
        
    }
    
    
    func register(){
        AuthService.sharedAuthService.registerUser(email: email, password: password){ success, error in
            
            if let error = error {
                print(error.localizedDescription)
            }else{
                registrationSuccess = success
            }
        }
    }
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View{
        RegisterView()
    }
}


