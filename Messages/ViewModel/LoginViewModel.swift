//
//  LoginViewModel.swift
//  Messages
//
//  Created by Cleber Reis on 01/04/21.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool {  get }
}

struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
