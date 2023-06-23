//
//  BaseViewController.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 21/06/23.
//

import UIKit

class BaseViewController: UIViewController {
    private let activityView = UIActivityIndicatorView(style: .large)
    internal let resultTableView = UITableView()
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

extension BaseViewController: ErrorHandling{
    func showError(msg : Error){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Erro", message: msg.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


protocol ErrorHandling{
    
    func showError(msg : Error)
    
}

