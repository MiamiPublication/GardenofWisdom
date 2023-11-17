//
//  GardenofWisdomApp.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2023-11-17.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct GardenofWisdomApp: App {
    @State private var isLoggedIn = false

    let authService = AuthService.sharedAuthService // Use the shared instance of AuthService



        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate



        var body: some Scene {

            WindowGroup {

                NavigationView {

                    if isLoggedIn {

                        ContentView()

                            .navigationBarTitle("Categories")

                            .navigationBarItems(trailing:

                                Button(action: {

                                   logout()

                                }) {

                                    Text("Logout")

                                }

                            )

                    } else {

                        LoginView { success in

                            // Update isLoggedIn based on the result of the login attempt

                            isLoggedIn = success



                            // Navigate to ContentView when isLoggedIn is true

                            if success {

                                NavigationLink(destination: ContentView()) {

                                    EmptyView()

                                }

                                .hidden() // This link is here just to trigger navigation

                            }

                        }

                        .navigationBarHidden(true)

                    }
                }
            }
        }

        

        func logout() {

            authService.signOutUser { success, error in

                       if success {

                           // Update isLoggedIn after successful sign out

                           isLoggedIn = false

                       } else if let error = error {

                           print("Error signing out: \(error.localizedDescription)")

                       }

                   }
        }

    }
