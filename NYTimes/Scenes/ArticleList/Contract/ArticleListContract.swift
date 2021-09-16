//
//  ArticleListContract.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation

enum ArticlePeriod: Int, Codable {
    
    case oneDay = 1
    case sevenDay = 7
    case thirtyDays = 30
    
    var title: String {
        switch self {
        case .oneDay:
            return "One Day"
        case .sevenDay:
            return "Seven Days"
        case .thirtyDays:
            return "Thirty Days"
        }
    }
    
    static var allPeriods : [ArticlePeriod] {
        return [.oneDay, sevenDay, thirtyDays]
    }
}

protocol ArticleListView: AnyObject {
    func initView()
    func showLoading()
    func hideLoading()
    func displayError(_ err: ArticleViewModel.FetchError)
    func displayArticles(_ articles: [ArticleViewModel.ViewModel])
}

protocol ArticleListPresentation: AnyObject {
    func initView()
    func loadArticlesFor(period: ArticlePeriod)
    func showArticleDetail(viewController: ArticleListViewController, datasource: ArticleViewModel.ViewModel)
}

protocol ArticleListUseCase: AnyObject {
    func fetchArticlesFor(period: ArticlePeriod)
}

protocol ArticleListInteractorOutput: AnyObject {
    func fetchedArticles(articles: [Article])
    func articleFetchFailed(_ err: Error)
}

protocol ArticleListWireframe: AnyObject {
    func pushToDetailScreen(viewController:ArticleListViewController, datasource: ArticleViewModel.ViewModel)
}

