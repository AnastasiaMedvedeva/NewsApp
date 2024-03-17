//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Анастасия on 14.02.2024.
//

import Foundation
import UIKit

final class GeneralViewModel: NewsListViewModel {
    override func loadData() {
        super.loadData()
        ApiManager.getNews(from: .general, page: page) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
