//
//  Singleton.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 11/02/2025.
//
/*
 Singleton-
 its a design pattern that ensures a class has only one instance which is gloabl shared point of access
 
 Basic idea behinde this one is to restrict multiple objects creation,
 this we can achive making init as private
 
 typical use case for singleton
 DataBaseManager (CoreData or Realm)
 AuthenticationManager
 FileDownload manager
 Analytics Manager
 
 disadvantage
 -Globalstate
 - this object will stay in memory even if ur task is done
 - Singleton are difficult to write test cases
 -Tightcoupling
 -threadsafe
 
 
 */
import Foundation

final class AuthManager{
  
  static let shared = AuthManager()
    
   private init (){}
    
     var isLoggedIn:Bool = false
     var authToken = ""
    
    func doLogin(token:String){
        self.authToken = token
        isLoggedIn = true
    }
    
    func logout(){
        isLoggedIn = false
        authToken = ""
    }
    
}
