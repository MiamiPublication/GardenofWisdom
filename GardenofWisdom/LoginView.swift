//
//  LoginView.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2023-11-26.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = "b.jaboori@gmail.com"
    @State private var password: String = "123456"
    
    var onLoginSuccess: (Bool) -> Void
    @State private var isRegisterActive: Bool = false
    
    
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
                    login()
                }){
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                NavigationLink(destination: RegisterView()){
                    Text("Register")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 20)
                }
                Spacer()
 
                    
            }
            .padding()
            .background(Color.teal)
        }
        
    }
    
    func login() {

        AuthService.sharedAuthService.loginUser(email: email, password: password) { success, error in

                    if let error = error {

                        print(error.localizedDescription)

                    } else {

                        onLoginSuccess(true)

                    }

                }

            }


}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View{
        LoginView{_ in}
    }
}

