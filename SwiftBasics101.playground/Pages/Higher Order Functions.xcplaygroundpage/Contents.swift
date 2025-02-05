//: [Previous](@previous)

import Foundation

var numbers = [1,2,3,4,5]

numbers = numbers.map { $0 * $0 }

print(numbers)

let sumOfAll = numbers.reduce(0, +)

print(sumOfAll)

// flatMap flattens nested collection

let mixArray = [[1,2,3,4,5],[6,7,8,9,10]]
print(mixArray.flatMap { $0 })

// compactMap - removes all nil from collection
let mixedArray2: [Int?] = [1,2,nil,3,4,nil]
print(mixedArray2.compactMap { $0 })

let students : Dictionary<String, [Int]> = ["Alice": [1,2,3], "Bob": [4,5]]

students.forEach{print("\($0.key): \($0.value)")}




enum APIError:Error{
    case invalidURL
    case serverError(Int)
    case noDataFound
}
func fetchDataFromAPI(urlString:String, completionHandler: @escaping (Data?, APIError?) -> Void) {
    print("Start of api call")
    guard let url = URL(string:urlString)else{
        completionHandler(nil, APIError.invalidURL)
        return
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) { data, urlresponse, error in
        
        if let error = error{
            completionHandler(nil, APIError.noDataFound)
            return
        }
        
        if let response = urlresponse as? HTTPURLResponse{
            if response.statusCode < 200 || response.statusCode > 299{
                completionHandler(nil, APIError.serverError(response.statusCode))
                return
            }
        }
        
        guard let receivedData = data else{
            completionHandler(nil,APIError.noDataFound)
            return
        }
        completionHandler(receivedData,nil)
    }
    dataTask.resume()
    print("End of api call")
}
    
fetchDataFromAPI(urlString: "https://dummyjson.com/products") { data, error in
    print("Got response")
    if let data = data{
        print(data.count)
    }else{
        print(error?.localizedDescription ?? "some error occured")
    }
    
}
//: [Next](@next)
