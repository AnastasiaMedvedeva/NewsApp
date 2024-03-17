//
//  TabBarController.swift
//  NewsApp
//
//  Created by Анастасия on 13.02.2024.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .black
        setupViewControllers()
    }
    
    // MARK: - Private methods
    private func setupViewControllers() {
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(viewModel: GeneralViewModel()), title: "General", image: UIImage(systemName: "newspaper") ?? UIImage.add),
            setupNavigationController(rootViewController: BusinessViewController(viewModel: BusinessViewModelProtocol.self as! BusinessViewModelProtocol), title: "Business", image: UIImage(systemName: "briefcase") ?? UIImage.add),
            setupNavigationController(rootViewController: TechnologyViewController(viewModel: TechnologyViewModelProtocol.self as! TechnologyViewModelProtocol), title: "Technology", image: UIImage(systemName: "gyroscope") ?? UIImage.add)
        ]
    }
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.scrollEdgeAppearance = appearance
        view.tintColor = .black
    }
    // MARK: - Methods
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController
    {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
}
