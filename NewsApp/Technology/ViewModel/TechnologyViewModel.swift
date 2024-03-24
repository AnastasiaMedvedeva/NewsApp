//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Анастасия on 26.02.2024.
//

import Foundation
import UIKit

final class TechnologyViewModel: NewsListViewModel {
    override func loadData(searchText: String?) {
        super.loadData()
        ApiManager.getNews(from: .technology,
                           page: page,
                           searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
