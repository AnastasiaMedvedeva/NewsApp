//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Анастасия on 14.02.2024.
//

import Foundation
import UIKit

struct ArticleCellViewModel {
    let title: String
    let description: String
    let date: String
    var  imageData: Data?
    let imageUrl: String
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        date = article.date
        imageUrl = article.urlToImage
    }
}
