//
//  Authorization.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/19/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

class Authorization {
    
    static let shared = Authorization()
    
    private let defaults = UserDefaults.standard
    
    
    private var _isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: "IS_LOGGED_IN_KEY")
        }
        set {
            defaults.set(newValue, forKey: "IS_LOGGED_IN_KEY")
        }
    }
    
    private var _token: String {
        get {
            return defaults.value(forKey: "TOKEN_KEY") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "TOKEN_KEY")
        }
    }
    
    public var isLoggedIn: Bool {
        return _isLoggedIn
    }
    
    public var token: String {
        return _token
    }
    
    public func authenticationUser(token: String, isLoggedIn: Bool) {
        self._token = token
        self._isLoggedIn = isLoggedIn
    }
    
    public func logOutAuth() {
        self._isLoggedIn = false
        self._token = ""
    }
    
    
}
