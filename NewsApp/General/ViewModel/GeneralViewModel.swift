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
    var numberOfCells: Int { get }
    func getArticle(for row: Int) -> ArticleCellViewModel
    var showError: ((String) -> Void)? { get set }
    }

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
     var articles: [ArticleResponseObject] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                self.reloadData?()
            }
        }
    }
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    // MARK: -  Initializations
    init() {
        loadData()
    }
    var numberOfCells: Int {
        articles.count
    }
    // MARK: - Private methods
   private func loadData() {
       ApiManager.getNews { [weak self] result in 
           switch result {
           case .success(let articles):
               self?.articles = articles
           case .failure(let error):
               DispatchQueue.main.async {
                   self?.showError?(error.localizedDescription)
               }
           }
       }    }
    private func setupMockObjects() {
        articles = [
            ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023"),
            ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023"),
            ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023"),
            ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023"),
            ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023")
        ]
    }
    // MARK: - Methods
    func getArticle(for row: Int) -> ArticleCellViewModel {
        let article = articles[row]
        return ArticleCellViewModel(article: article)
    }
    
}
