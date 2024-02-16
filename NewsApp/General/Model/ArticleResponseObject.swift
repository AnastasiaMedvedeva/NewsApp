//
//  ArticleResponseObject.swift
//  NewsApp
//
//  Created by Анастасия on 14.02.2024.
//

import Foundation
import UIKit

struct ArticleResponseObject: Codable {
    let title: String
    let description: String
    let urlToImage: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case date = "publishedAt"
    }
}
