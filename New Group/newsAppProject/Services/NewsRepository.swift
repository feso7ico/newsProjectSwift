//
//  NewsRepository.swift
//  newsAppProject
//
//  Created by Mac on 03/11/25.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getTechNews() async throws -> [NewsArticle]
}

class NewsRepository: NewsRepositoryProtocol {
    private let apiKey = "11d37df6d9af43669938811df567a399"
    private let baseURL = "https://newsapi.org/v2/top-headlines?sources=techcrunch"

    func getTechNews() async throws -> [NewsArticle] {
        let url = "\(baseURL)&apiKey=\(apiKey)"
        let response: NewsResponse = try await NetworkManager.shared.fetchData(from: url)
        return response.articles
    }
}

