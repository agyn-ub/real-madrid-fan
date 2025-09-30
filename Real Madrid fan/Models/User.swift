//
//  User.swift
//  Real Madrid fan
//
//  Created by Assistant on 30.09.2025.
//

import Foundation

struct User: Identifiable {
    let id: String
    let email: String?
    let displayName: String?
    
    var displayNameOrEmail: String {
        if let displayName = displayName, !displayName.isEmpty {
            return displayName
        } else if let email = email {
            return email.components(separatedBy: "@").first ?? "Madridista"
        }
        return "Madridista"
    }
    
    var initials: String {
        let name = displayNameOrEmail
        let components = name.components(separatedBy: " ")
        
        if components.count >= 2 {
            let firstInitial = components[0].prefix(1).uppercased()
            let lastInitial = components[1].prefix(1).uppercased()
            return "\(firstInitial)\(lastInitial)"
        } else {
            return name.prefix(2).uppercased()
        }
    }
}