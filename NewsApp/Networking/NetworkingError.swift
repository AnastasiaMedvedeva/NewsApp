//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Анастасия on 16.02.2024.
//

import Foundation
import UIKit

enum NetworkingError: Error {
case NetworkingError(_ error: Error)
    case unknown
}
