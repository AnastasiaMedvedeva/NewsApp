//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Анастасия on 14.02.2024.
//

import Foundation
import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private lazy var contentView = UIView()
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "travel") ?? UIImage.add
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "22.04.2000"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some title for the news"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lllllllllllllllllllllllllljfdjhjfhjhfjdfhdkhfkjfhkdjfhdjkfhdjfkhfjfhdfjdfhwuey2urty4rop[p0248456544i3h;kds,/jgi58y890231pkjbfklkd;saz.fvfsdsjwiqtryueiowp[q]  wertyui][poiuytrewqasdfghjkl;'/.,mnbvcxzyhb fcjktgf9uiojlk434wfddfgfhshsgfdhffdgfdgshdfskjhfgaskjhsgfsjfgkshjfsgfdfghjkl;nbvcghjklfdshjke"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Private properties
    let edgeInsets = 15
 
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
      setupUI()
   }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        setupConstraints()
    }
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView).inset(0)
            make.height.width.equalTo(view.frame.width)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(edgeInsets)
            make.leading.trailing.equalTo(contentView).inset(edgeInsets)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView).inset(edgeInsets)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView).inset(edgeInsets)
        }
    }
}
