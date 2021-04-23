//
//  ProfileViewModel.swift
//  Messages
//
//  Created by Cleber Reis on 22/04/21.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    
    var description: String {
        switch self {
            case .accountInfo:
                return "Account Info"
            case .settings:
                return "Settings"
        }
    }
    
    var iconTimageName: String {
        switch self {
            case .accountInfo:
                return "person.circle"
            case .settings:
                return "gear"
        }
    }
}
