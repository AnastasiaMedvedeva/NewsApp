//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Анастасия on 14.02.2024.
//

import Foundation
import UIKit

final class ArticleCellViewModel: TableCollectionViewItemsProtocol {
    let title: String
    let description: String
    let imageUrl: String
    var imageData: Data?
    
    var date: String
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        date = article.date
        imageUrl = article.urlToImage
        
        if let formatDate = formatDate(dateString: self.date) {
            self.date = formatDate
        }
    }
    private func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
