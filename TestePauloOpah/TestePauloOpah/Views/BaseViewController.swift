//
//  BaseViewController.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 21/06/23.
//

import UIKit

class BaseViewController: UIViewController {
    private let activityView = UIActivityIndicatorView(style: .large)
    internal let tableView = UITableView()
    internal var safeArea = UILayoutGuide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        
        view.backgroundColor = .white
    }

    internal func activityIndicatorShould(appear: Bool){
        if appear {
            activityView.center = self.view.center
            UIView.animate(withDuration: 0.25, delay:0, options: .transitionCrossDissolve, animations: {
                self.view.addSubview(self.activityView)
                self.activityView.startAnimating()
            })
        }else{
            activityView.stopAnimating()
            UIView.animate(withDuration: 0.25, delay:0, options: .transitionCrossDissolve, animations: {
                self.activityView.removeFromSuperview()
            })
        }
    }
    
    
}