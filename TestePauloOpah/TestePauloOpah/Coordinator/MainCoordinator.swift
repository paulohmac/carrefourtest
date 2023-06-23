//
//  MainCoordinator.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit


protocol Coordinator{
    
    var spy : CoordinatorSpy?{get set}

    func openDetail(id: String)
    
    static func getInstance()->Coordinator

}

protocol CoordinatorSpy{
    
    func detailViewControllerOpened()
}

class MainCoordinator : Coordinator {

    static func getInstance() -> Coordinator {
        return MainCoordinator()
    }
    
    var spy: CoordinatorSpy?
    
    private static var instance: Coordinator = MainCoordinator()
    
    private func getRootViewController()->UINavigationController{
        let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = scenes?.windows.last
        return window?.rootViewController as? UINavigationController ?? UINavigationController()
    }
    
    public func openDetail(id: String){
        let detailViewController  = DetailViewController()
        detailViewController.idLogin = id
        detailViewController.viewModel = DetailGitViewModel(factory: ServiceFactory())
        getRootViewController().pushViewController(detailViewController, animated: true)
        spy?.detailViewControllerOpened()
    }
    
}
