//
//  ArticleDetailRouter.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation
import UIKit

class ArticleDetailRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ArticleDetailViewController {
        let viewController = UIStoryboard.loadViewController() as ArticleDetailViewController
        let presenter = ArticleDetailPresenter()
        let router = ArticleDetailRouter()
        let interactor = ArticleDetailInteractor()

        viewController.detailPresenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ArticleDetailRouter: ArticleDetailWireframe {
    // TODO: Implement wireframe methods
}

