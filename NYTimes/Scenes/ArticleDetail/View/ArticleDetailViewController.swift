//
//  ArticleListViewController.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation
import UIKit

class ArticleDetailViewController: UIViewController, StoryboardLoadable {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    // MARK: Properties

    var datasource: ArticleDetailViewModel.ViewModel?
    var detailPresenter: ArticleDetailPresentation?
    

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailPresenter?.initView()
        detailPresenter?.loadArticleDetail()
    }
    
}

extension ArticleDetailViewController: ArticleDetailView {
    func initView() {
        //TODO: Init views
    }
        
    func displayError(_ err: ArticleViewModel.FetchError) {
        print("\(err.title): \(err.message)")
    }
    
    
    func displayArticleDetail(_ article: ArticleDetailViewModel.ViewModel) {
        
        DispatchQueue.main.async {
            self.datasource = article
            guard let datasource = self.datasource else {return}
            if let url = URL(string: datasource.thumbnailImage) {
                self.imgView.setImage(url)
            }
            
            self.lblTitle.text = datasource.title
            self.lblDesc.text = datasource.abstract
        }
    }
    
}

