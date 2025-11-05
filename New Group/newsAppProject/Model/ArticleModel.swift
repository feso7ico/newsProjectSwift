//
//  ArticleModel.swift
//  newsAppProject
//
//  Created by Mac on 03/11/25.
//

import Foundation
struct NewsSource: Codable, Hashable, Identifiable {
    let id: String?
    let name: String
}

struct NewsArticle: Codable, Hashable, Identifiable {
    var id: String { publishedAt }
    let source: NewsSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    var publishedDate: Date? {
        ISO8601DateFormatter().date(from: publishedAt)
    }
}

struct NewsResponse: Codable {
    let articles: [NewsArticle]
}
