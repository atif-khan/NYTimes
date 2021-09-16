//
//  ArticleDetailInteractor.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation

protocol ArticleDetailDataStore {
    var datasource: Article! { get set }
}

class ArticleDetailInteractor {

    // MARK: Properties

    weak var output: ArticleDetailInteractorOutput?
    
    var datasource: Article!
}

extension ArticleDetailInteractor: ArticleDetailUseCase {
    func fetchArticleDetail() {
        output?.fetchedArticleDetail(article: datasource)
    }
    
    func saveArticleDetail(detail: Article) {
        datasource = detail
    }
}

extension ArticleDetailInteractor: ArticleDetailDataStore {
}
