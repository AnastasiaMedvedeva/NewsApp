//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Анастасия on 17.03.2024.
//

import Foundation

protocol NewsListViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell:((IndexPath) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    
    func loadData(searchText: String?)
    }
class NewsListViewModel: NewsListViewModelProtocol {
        var reloadCell:((IndexPath) -> Void)?
        var reloadData: (() -> Void)?
        var showError: ((String) -> Void)?
        
        // MARK: - Properties
        var sections: [TableCollectionViewSection] = [] {
            didSet {
                DispatchQueue.main.async { [self] in
                    self.reloadData?()
                }
            }
        }
       var page = 0
    var searchText: String? = nil
        // MARK: - Methods
    func loadData(searchText: String? = nil) {
       page += 1
        self.searchText = searchText
    }
        func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
            let viewModels = articles.map { ArticleCellViewModel(article: $0) }
            
            if sections.isEmpty {
                let firstSection = TableCollectionViewSection(items: viewModels)
                sections = [firstSection]
            } else {
                sections[0].items += viewModels
            }
        }
    
    func handleResult(_ result: Result<[ArticleResponseObject], Error>) {
        switch result {
        case .success(let articles):
            self.convertToCellViewModel(articles)
            self.loadImage()
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }
        // MARK: - Private methods
        private func setupMockObjects() {
            sections = [
                TableCollectionViewSection(items: [ArticleCellViewModel(article: ArticleResponseObject(title: "1", description: "one one one", urlToImage: "//236yu", date: "12.12.2023"))])
            ]
        }
        
        private func loadImage() {
            for  (i,section) in sections.enumerated() {
                for (index, item) in section.items.enumerated() {
                    if let article = item as? ArticleCellViewModel,
                       let url = article.imageUrl {
                        ApiManager.getImageData(url: url) { [weak self] result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let data):
                                    if let article = self?.articles[i].items[index] as? ArticleCellViewModel {
                                        article.imageData = data
                                    }
                                    self?.reloadCell?(IndexPath(row: index, section: i))
                                case .failure(let error):
                                    self?.showError?(error.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
