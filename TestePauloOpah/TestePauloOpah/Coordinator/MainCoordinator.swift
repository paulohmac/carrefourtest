//
//  MainCoordinator.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit


protocol Coordinator{
    
    static var instance : Coordinator{ get }

    func openDetail(id: String)
    
}

extension Coordinator{

    static func getInstance()->Coordinator{
      return instance
    }
}

class MainCoordinator : Coordinator {
    static var instance: Coordinator = MainCoordinator()
    
    private func getRootViewController()->UINavigationController{
        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController ?? UINavigationController()
    }
    
    public func openDetail(id: String){
        let detailViewController  = DetailViewController()
        detailViewController.idLogin = id
        detailViewController.viewModel = DetailGitViewModel(factory: ServiceFactory())
        getRootViewController().pushViewController(detailViewController, animated: true)
        
    }
    
}
