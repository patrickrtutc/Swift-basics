//
//  Todo.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 12/02/2025.
//


struct Todo:Decodable{
    let userId:Int
    let id: Int
    let title: String
    let completed : Bool
}

/*
 {
   "userId": 1,
   "id": 1,
   "title": "delectus aut autem",
   "completed": false
 }
 */
