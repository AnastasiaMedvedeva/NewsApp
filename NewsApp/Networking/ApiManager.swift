//
//  ApiManager.swift
//  NewsApp
//
//  Created by Анастасия on 16.02.2024.
//

import Foundation
import UIKit
final class ApiManager {
    static private let apiKey = "cd2962bd3c694b4885023b613ab23108"
    static private let baseUrl = "https://newsapi.org/v2/"
    static private let path = "everything"
    
    static func getNews(completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        let stringUrl = baseUrl + path + "?sources=bbs-news&language=en" + "&apiKey=\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
    handleResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    private static func handleResponse(data: Data?, error: Error?, completion: @escaping(Result<[ArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.NetworkingError(error)))
        } else if let data = data {
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                completion(.success(model.articles))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    static func getImageData(url: String, completion: @escaping(Result<Data,Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
}
