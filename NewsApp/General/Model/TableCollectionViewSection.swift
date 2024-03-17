//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Анастасия on 16.03.2024.
//

import Foundation

protocol TableCollectionViewItemsProtocol {
    
}

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
