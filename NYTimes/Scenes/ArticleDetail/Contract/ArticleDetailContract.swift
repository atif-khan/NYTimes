//
//  ArticleDetailContract.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation

protocol ArticleDetailView: AnyObject {
    func initView()
    func displayError(_ err: ArticleViewModel.FetchError)
    func displayArticleDetail(_ article: ArticleDetailViewModel.ViewModel)
}

protocol ArticleDetailPresentation: AnyObject {
    func initView()
    func loadArticleDetail()
    func saveArticleDetail(detail: Article)
}

protocol ArticleDetailUseCase: AnyObject {
    func fetchArticleDetail()
    func saveArticleDetail(detail: Article)
}

protocol ArticleDetailInteractorOutput: AnyObject {
    func fetchedArticleDetail(article: Article)
    func articleFetchFailed(_ err: Error)
}

protocol ArticleDetailWireframe: AnyObject {
    // TODO: Declare wireframe methods
}
