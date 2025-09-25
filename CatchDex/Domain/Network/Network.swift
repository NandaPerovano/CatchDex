//
//  Network.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(underlying: Error)
    case badStatus(Int)
    case decodingFailed(underlying: Error)
}

protocol NetworkProvider {
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T
}

final class Network: NetworkProvider {
    
    // MARK: - Private Properties
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Initializers
    
    init(session: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 15
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }(),
         
         decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        do {
            let (data, response) = try await session.data(from: url)
            if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
                throw NetworkError.badStatus(http.statusCode)
            }
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed(underlying: error)
            }
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
}
