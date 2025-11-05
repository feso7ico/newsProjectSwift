//
//  NewsDetailView.swift
//  newsAppProject
//
//  Created by Mac on 03/11/25.
//

import SwiftUI

struct NewsDetailView: View {
    let article: NewsArticle
    @Environment(\.openURL) var openURL
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let urlStr = article.urlToImage, let url = URL(string: urlStr) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                Rectangle().foregroundColor(.gray.opacity(0.2)).frame(height: 220)
                                    .overlay(ProgressView())
                            case .success(let image):
                                image.resizable().scaledToFill().frame(maxWidth: .infinity, minHeight: 220, maxHeight: 320).clipped()
                            case .failure:
                                Rectangle().foregroundColor(.gray.opacity(0.2)).frame(height: 220)
                                    .overlay(Image(systemName: "photo"))
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(article.title)
                            .font(.title2)
                            .bold()
                        HStack {
                            if let author = article.author {
                                Text(author).font(.subheadline).foregroundColor(.secondary)
                            }
                            Spacer()
                            if let date = article.publishedDate {
                                Text(date, style: .date).font(.caption).foregroundColor(.secondary)
                            }
                        }

                        if let description = article.description {
                            Text(description).font(.body)
                        }

                        if let content = article.content {
                            Text(content).font(.body).foregroundColor(.primary)
                        }

                        Button(action: openArticle) {
                            Label("Abrir fuente", systemImage: "safari")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(article.source.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    private func openArticle() {
            if let url = URL(string: article.url) {
                openURL(url)
            }
    }
}

