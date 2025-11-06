//
//  NewsListView.swift
//  newsAppProject
//
//  Created by Mac on 03/11/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        
        NavigationStack {
            List(viewModel.articles) { article in
                NavigationLink(value: article) {
                    if viewModel.isLoading {
                        ProgressView("load news.......")
                    } else if let error = viewModel.errorMessage{
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        HStack(alignment: .top, spacing: 12) {
                            ThumbnailView(urlString: article.urlToImage)
                                .frame(width: 90, height: 60)
                                .cornerRadius(8)
                            VStack(alignment: .leading, spacing: 6) {
                                Text(article.title)
                                    .font(.headline)
                                    .lineLimit(2)
                                HStack {
                                    Text(article.source.name)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    if let date = article.publishedDate {
                                        Text(date, style: .date)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
                    }
                    .task {
                        await viewModel.fetchNews()
                    }
                    .navigationTitle("Noticias")
                    .navigationDestination(for: NewsArticle.self) { article in
                        NewsDetailView(article: article)
                    }
            
                }
    }
}

#Preview {
    NewsListView()
}

struct ThumbnailView: View {
    let urlString: String?

    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.2)
                        .overlay(ProgressView().scaleEffect(0.8))
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    Color.gray.opacity(0.2)
                        .overlay(Image(systemName: "photo").foregroundColor(.white))
                @unknown default:
                    Color.gray
                }
            }
        } else {
            Color.gray.opacity(0.2)
                .overlay(Image(systemName: "photo").foregroundColor(.white))
        }
    }
}

