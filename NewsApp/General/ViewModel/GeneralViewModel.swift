//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Анастасия on 14.02.2024.
//

import Foundation
import UIKit

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var articles: [ArticleResponseObject] { get set }
    func getArticle(for row: Int) -> ArticleCellViewModel { get set }
    }

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadData: (() -> Void)?
    
    // MARK: - Properties
    var articles: [ArticleResponseObject] = []
    // MARK: -  Initializations
    init() {
        loadData()
    }
    // MARK: - Private methods
   private func loadData() {
        
    }
    // MARK: - Methods
    func getArticle(for row: Int) -> ArticleCellViewModel {
        let article = articles[row]
        return ArticleCellViewModel(article: article)
    }
}
