//
//  NewsViewModel.swift
//  swift-ui-sqlite
//
//  Created by Ravi Bastola on 1/3/21.
//

import Foundation
import Combine

final class NewsViewModel {
    var subscription: Set<AnyCancellable> = []
    
    var urlComponents: URLComponents  {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "newsapi.org"
        return component
    }
    
    @Published private (set) var articles: [Article] = []
    
    func fetch() {
        
    }
    
    fileprivate func fromNetwork() {
        
        var innerUrl = urlComponents
        
        innerUrl.path = "/v2/top-headlines"
        
        var urlQueryItem: [URLQueryItem] = []
        
        let queryItems: [String: String]  = [
            "country": "in",
            "category": "business",
            "apiKey": "721e810f5e984c8b8529b6816ad464b4"
        ]
        
        for (key, data) in queryItems  {
            urlQueryItem.append(.init(name:key, value: data))
        }
        
        innerUrl.queryItems = urlQueryItem
        
        let newsFromNetwork = NewsFromNetwork(subscription: subscription)
        newsFromNetwork.fetch(request: URLRequest(url: innerUrl.url!)){ result in
            switch result{
            case let .success(news):
                self.articles = news.articles
            case .failure(_):
                break
            }
        }
    }
    
    func save(_ articles: [Article]) {
        
    }
}

