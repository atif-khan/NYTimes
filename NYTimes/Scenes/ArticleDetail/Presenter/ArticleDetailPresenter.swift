//
//  ArticleDetailPresenter.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation

class ArticleDetailPresenter {

    // MARK: Properties

    weak var view: ArticleDetailView?
    var router: ArticleDetailWireframe?
    var interactor: ArticleDetailUseCase?
}

extension ArticleDetailPresenter: ArticleDetailPresentation {
    
    func initView() {
        view?.initView()
    }
    
    func loadArticleDetail() {
        interactor?.fetchArticleDetail()
    }
    
    func saveArticleDetail(detail: Article) {
        interactor?.saveArticleDetail(detail: detail)
    }

}

extension ArticleDetailPresenter: ArticleDetailInteractorOutput {
    func fetchedArticleDetail(article: Article) {
        view?.displayArticleDetail(convertArticleToViewModel(article: article))
    }
    
    
    func articleFetchFailed(_ err: Error) {
        view?.displayError(ArticleViewModel.FetchError(message: err.localizedDescription, title: "Error"))
    }
    
    
    func convertArticleToViewModel(article: Article) -> ArticleDetailViewModel.ViewModel {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateformatter.date(from: article.updated) ?? Date()
        dateformatter.dateStyle = .short
        
        let thumbNailImage = article.media.first?.mediaMetadata.filter { $0.format == MediaMetaDataFormat.mediumThreeByTwo210.rawValue }.first
        
        
        let viewModel: ArticleDetailViewModel.ViewModel = ArticleDetailViewModel.ViewModel(id: article.id, title: article.title, abstract: article.abstract ,author: article.byline, date: "Published on: \(dateformatter.string(from: date))", section: article.section, thumbnailImage: thumbNailImage?.url ?? "")
        
        
        return viewModel
    }
}
