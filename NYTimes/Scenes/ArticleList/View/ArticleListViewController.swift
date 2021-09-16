//
//  ArticleListViewController.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation
import UIKit

class ArticleListViewController: UIViewController, StoryboardLoadable {

    // MARK: Properties
        
    @IBOutlet weak var cvArticles: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var datasource = [ArticleViewModel.ViewModel]()
    var listPresenter: ArticleListPresentation?
    


    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViper()
        
        listPresenter?.initView()
        listPresenter?.loadArticlesFor(period: ArticlePeriod.sevenDay)
    }
    
    func initViper() {
        
        // Article List Router
        let presenter = ArticleListPresenter()
        let router = ArticleListRouter()
        let interactor = ArticleListInteractor()

        router.datasource = interactor.datasource
        self.listPresenter =  presenter

        presenter.view = self
        presenter.router = router
        presenter.interactor = interactor

        router.view = self

        interactor.output = presenter
    }
}

extension ArticleListViewController: ArticleListView {
    
    func initView() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        
        configureCollectionView()
    }
    
    func showLoading() {
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            
            UIView.animate(withDuration: 0.1) {
                self.cvArticles.alpha = 0.0
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            UIView.animate(withDuration: 0.1) {
                self.cvArticles.alpha = 1.0
            }
        }
    }
    
    func displayError(_ err: ArticleViewModel.FetchError) {
        print("\(err.title): \(err.message)")
    }
    
    func displayArticles(_ articles: [ArticleViewModel.ViewModel]) {
        
        DispatchQueue.main.async {
            
            self.datasource = articles
            self.cvArticles.reloadData()
        }
    }
    
}


// MARK: - UICollectionViewDataSource

extension ArticleListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleListViewCell.identifier, for: indexPath) as! ArticleListViewCell
        
        let model = datasource[indexPath.row]
        
        cell.configureCell(model)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ArticleListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listPresenter?.showArticleDetail(viewController: self, datasource: datasource[indexPath.item])
    }
}

// MARK: - Helpers

extension ArticleListViewController {
    
    func configureCollectionView() {
        
        cvArticles.alpha = 0.0
        
        cvArticles.register(UINib(nibName: "ArticleListViewCell", bundle: nil), forCellWithReuseIdentifier: ArticleListViewCell.identifier)
        
        cvArticles.collectionViewLayout  = MainCollectionLayoutHelper().generateLayout()
        
        cvArticles.dataSource = self
        cvArticles.delegate = self
    }
    
}
