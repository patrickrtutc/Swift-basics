//
//  ClosureDesignPattern.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 12/02/2025.
//
/*
 ClosureDesignPattern- use of closures for object or data transfer
 */
import Foundation

class MyNetworkManager{
    
    func loadDataFromAPI<T:Decodable>(url:URL, modelType:T.Type, completionHandler: @escaping (Result<T,Error>) -> Void){
        print("Start of loadDataFromAPI method")

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                if let data = data{ // bytes
                    let receivedResponse =   try JSONDecoder().decode(modelType, from: data)
                    completionHandler(.success(receivedResponse))
                }
            }catch{
                print(error.localizedDescription)
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
        print("End of loadDataFromAPI method")
    }
}
