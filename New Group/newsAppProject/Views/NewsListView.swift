//
//  NewsListView.swift
//  newsAppProject
//
//  Created by Mac on 03/11/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    @State private var articles: [NewsArticle] = [.sample]
    
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

extension NewsArticle {
    static let sample = NewsArticle(
        source: NewsSource( id: "dsds", name: "The Times of India"),
        author: "Reuters",
        title: "Samsung SDI says discussing supplying Tesla with ESS batteries",
        description: "Samsung SDI is in discussions to supply Tesla with energy storage system batteries. This potential deal is valued at over two billion dollars. The agreement would help Tesla reduce its dependence on China for crucial components. South Korean battery makers ar…",
        url: "https://economictimes.indiatimes.com/news/international/business/samsung-sdi-says-discussing-supplying-tesla-with-ess-batteries/articleshow/125073466.cms",
        urlToImage: "https://img.etimg.com/thumb/msid-125073520,width-1200,height-630,imgsize-5606,overlay-economictimes/articleshow.jpg",
        publishedAt: "2025-11-04T02:54:38Z",
        content: "South Korea's Samsung SDI is discussing supplying ESS (Energy Storage System) batteries to Tesla in an order reported to be worth around 3 trillion won ($2.11 billion) or more.The deal, if signed, wo… [+848 chars]"
    )
}

