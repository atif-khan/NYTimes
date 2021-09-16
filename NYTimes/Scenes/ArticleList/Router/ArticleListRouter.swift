//
//  ArticleListRouter.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation
import UIKit


class ArticleListRouter: ArticleDataStore {
    var datasource: [Article]?
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

//    static func setupModule() -> ArticleListViewController {
//        let viewController = UIStoryboard.loadViewController() as ArticleListViewController
//        let presenter = ArticleListPresenter()
//        let router = ArticleListRouter()
//        let interactor = ArticleListInteractor()
//
//        router.datasource = interactor.datasource
//        viewController.listPresenter =  presenter
//
//        presenter.view = viewController
//        presenter.router = router
//        presenter.interactor = interactor
//
//        router.view = viewController
//
//        interactor.output = presenter
//
//        return viewController
//    }
}

extension ArticleListRouter: ArticleListWireframe {
    // TODO: Implement wireframe methods
    func pushToDetailScreen(viewController:ArticleListViewController, datasource: ArticleViewModel.ViewModel) {
        let detailModule = ArticleDetailRouter.setupModule()
        if let detail = (self.datasource?.first{$0.id == datasource.id}) {
            detailModule.detailPresenter?.saveArticleDetail(detail: detail)
        }
        viewController.show(detailModule, sender: nil)
    }
}
