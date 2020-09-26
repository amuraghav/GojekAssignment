//
//  ServiceManager.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import Foundation


// MARK:- BASE URL
let baseUrl = "https://ghapi.huchen.dev/"

// MARK:- NETWORK ERROR
enum NetworkError:CLongLong,Error {
    
    case unableToParse
    case unknown
    case noInternet = -1009
}

// MARK:- API REQUEST MODEL

struct APIRequest{
    let url: URL
    init(url: String) {
        let percentEncodedURLString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.url = Foundation.URL(string: percentEncodedURLString!)!
    }
}


class ServiceManager: NSObject{
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    // MARK:- API CALLING METHOD
    
    func performRequest<T : Decodable>(request: APIRequest, completion: @escaping (Swift.Result<T , NetworkError>) -> Void) {
        dataTask = defaultSession.dataTask(with: request.url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
//                print("Error : \(error)")
                ((error as NSError).code == NetworkError.noInternet.rawValue) ? completion(.failure(.noInternet)) : completion(.failure(.unknown))
               
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                do{
                    let values =  try JSONDecoder().decode(T.self, from: data)
                    completion(.success(values))
                }
                catch{
                    print("UNABLE TO PARSE STATUS CODE : \(error)")
                    completion(.failure(.unableToParse))
                }
            }
        }
        dataTask?.resume()
    }
    
}
