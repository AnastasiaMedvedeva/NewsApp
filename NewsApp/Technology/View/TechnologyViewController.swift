//
//  TechnologyViewController.swift
//  NewsApp
//
//  Created by Анастасия on 13.02.2024.
//

import Foundation
import UIKit

final class TechnologyViewController: UIViewController {
        // MARK: - GUI Variables
        private lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            return collectionView
        }()
        // MARK: - Properties
         private var viewModel: NewsListViewModelProtocol
        
        // MARK: - Initialization
        init(viewModel: NewsListViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
                self.setupViewModel()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Life cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            collectionView.register(TechnologyCollectionViewCell.self, forCellWithReuseIdentifier: "GeneralCollectionViewCell")
            collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsCollectionViewCell")
            viewModel.loadData(searchText: nil)
        }
        
        //MARK: - Private methods
        private func setupUI() {
            view.backgroundColor = .white
            view.addSubview(collectionView)
            setupConstraints()
        }
        
        private func setupConstraints() {
            collectionView.snp.makeConstraints { make in
                make.top.bottom.equalTo(view.safeAreaLayoutGuide)
               make.bottom.equalTo(view.safeAreaLayoutGuide)
                make.leading.trailing.equalToSuperview().inset(5)
            }
        }
        
        private func setupViewModel() {
            viewModel.reloadData = { [weak self] in
                self?.collectionView.reloadData()
                }
            viewModel.reloadCell = { [weak self] row in
                self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
            }
            viewModel.showError = { error in
                print(error)
            }
        }
    }
    //MARK: - UICollectionViewDataSource
    extension TechnologyViewController: UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            viewModel.numberOfCells > 1 ? 2 : 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if viewModel.numberOfCells > 1 {
                return section == 0 ? 1 : viewModel.numberOfCells - 1
            }
            return viewModel.numberOfCells
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell: UICollectionViewCell?
            if indexPath.section == 0 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell } else {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell".self, for: indexPath) as? DetailsCollectionViewCell
                    let article = viewModel.getArticle(for: indexPath.row + 1)
                    cell?.set(article: article)
                    return cell ?? UICollectionViewCell()
                }
        }
    }

    //MARK: - UICollectionViewDelegate
        extension TechnologyViewController: UICollectionViewDelegate {
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let article = viewModel.getArticle(for: indexPath.section == 0 ? 0 : indexPath.row + 1)
                navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)), animated: true)
            }
        }
    // MARK: - UICollectionViewDelegateFlowLayout
    extension TechnologyViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = view.frame.width
            let firstSectionItemSize = CGSize(width: width, height: width)
            let secondSectionItemSize = CGSize(width: width, height: width)
            return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
        }
}
