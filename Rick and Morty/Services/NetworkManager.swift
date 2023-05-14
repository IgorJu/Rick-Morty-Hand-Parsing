//
//  NetworkManager.swift
//  Rick and Morty
//
//  Created by Igor on 09.05.2023.
//

import Foundation
import Alamofire

enum Link {
    case personageURL
    
    var url: URL {
        switch self {
        case .personageURL:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchPersonages(from url: URL, completion: @escaping(Result<[Personage], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let personages = Personage.getPersonages(from: value)
                    completion(.success(personages))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
  

