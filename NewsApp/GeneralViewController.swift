//
//  ViewController.swift
//  NewsApp
//
//  Created by Анастасия on 13.02.2024.
//

import UIKit

class GeneralViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - searchBar.frame.height), collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

