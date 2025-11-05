//
//  NewsViewModel.swift
//  newsAppProject
//
//  Created by Mac on 03/11/25.
//

import Foundation
internal import Combine

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading = false

    private let repository: NewsRepositoryProtocol

    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }

    func fetchNews() async {
        isLoading = true
        do {
            let news = try await repository.getTechNews()
            articles = news
            print(articles)
        } catch {
            print("error")
            errorMessage = "Error al cargar noticias: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
