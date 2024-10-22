//
//  LoginViewViewModel.swift
//  Roomi
//
//  Created by Alec Morrison on 10/21/24.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        // try to log user in
        Auth.auth().signIn(withEmail: email, password: password)
        
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in : .whitespaces).isEmpty,
              !password.trimmingCharacters(in : .whitespaces).isEmpty else {
            
            errorMessage = "Please Fill In All Fields"
            
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please Enter Valid Email"
            return false
        }
        
        return true
    }
}
