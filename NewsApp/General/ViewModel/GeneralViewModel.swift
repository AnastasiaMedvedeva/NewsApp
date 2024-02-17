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
    var articles: [ArticleCellViewModel] { get set }
    var numberOfCells: Int { get }
    var showError: ((String) -> Void)? { get set }
    var reloadCell:((Int) -> Void)? { get set }
    func getArticle(for row: Int) -> ArticleCellViewModel
    }

final class GeneralViewModel: GeneralViewModelProtocol {
    var reloadCell:((Int) -> Void)?
    // MARK: - Properties
    var articles: [ArticleCellViewModel] = [] {
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
    func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articles.map { ArticleCellViewModel(article: $0) }
    }
    
    private func loadData() {
        ApiManager.getNews { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let articles):
                self.articles = self.convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }    }
    private func setupMockObjects() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023")),
            ArticleCellViewModel(article: ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023")),
            ArticleCellViewModel(article: ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023")),
            ArticleCellViewModel(article: ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023"))
        ]
    }
    // MARK: - Methods
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
    
    private func loadImage() {
        for (index, article) in articles.enumerated() {
            ApiManager.getImageData(url: articles[index].imageUrl) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
}
