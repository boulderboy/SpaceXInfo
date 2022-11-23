//
//  NetworkService.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 22.11.2022.
//

import Foundation

final class NetworkService {
    
    enum Constants {
        static let rocketUrl = "https://api.spacexdata.com/v4/rockets"
        static let launchUrl = "https://api.spacexdata.com/v4/launches"
    }
    
    enum Errors: Error {
        case invalidUrl
        case decodeError
        case responseError
    }
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void) {
        guard let url = URL(string: Constants.rocketUrl) else {
            completion(.failure(Errors.invalidUrl))
            return
        }
        let request = URLRequest(url: url)
        let dataTsk = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(Errors.invalidUrl))
                return
            }
            do {
                guard let data = data else {
                    completion(.failure(Errors.responseError))
                    return
                }
                self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let rockets = try self.jsonDecoder.decode([Rocket].self, from: data)
                completion(.success(rockets))
            } catch {
                print(error)
                completion(.failure(Errors.decodeError))
            }
        }
        dataTsk.resume()
    }
    
}
