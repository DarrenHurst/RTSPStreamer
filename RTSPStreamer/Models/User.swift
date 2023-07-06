//
//  User.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-01-26.
//

import Foundation
protocol UserProtocol {
    var user: User {get set}
}

struct Profile : Codable {
    var posts: [String] = [ ]
    var comments: [String] = [ ]
}

class User : ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var profile: Profile?
  
   init() {}

    @MainActor
    func authenticate(user: User) async -> User {
        if ( user.username.lowercased() == "admin" && user.password.lowercased() == "password") {
            user.isAuthenticated = true
        }
        print(user.username)
        print(user.password)
        return user
    }
   
    @MainActor
    func getLoggedInUser( user: User ) async -> (LoginResponseModel) {
        var profile = user.profile
        var newprofile: Profile? = Profile() // get from service
        Generics().swapAny(&profile,&newprofile)
       
        let loggedInUser: LoginResponseModel = LoginResponseModel.init(username: user.username, isAutenticated: user.isAuthenticated, profile: profile)
        return loggedInUser
    }
}

struct LoginErrorModel: Codable {
    var status: String?
    var errorCode: Int?
}
struct LoginResponseModel : Codable {
    var username: String
    var isAutenticated: Bool
    var profile: Profile?
    var errorStatus: LoginErrorModel?
}
