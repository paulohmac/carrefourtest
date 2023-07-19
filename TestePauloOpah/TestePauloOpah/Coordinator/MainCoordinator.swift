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
    static var instance : Coordinator?
    
    static func getInstance() -> Coordinator {
        return  instance ?? MainCoordinator()
    }
    
    var spy: CoordinatorSpy?
    
    var navigationViewController : UINavigationController?
    
    private func getRootViewController()->UINavigationController? {
        if navigationViewController != nil {
            return navigationViewController
        }else{
            let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let window = scenes?.windows.last
            let navigator =  window?.rootViewController
            
            if navigator is UINavigationController {
                navigationViewController = navigator as? UINavigationController
            }else{
                if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), let navigationController = keyWindow.rootViewController as? UINavigationController {
                    navigationViewController =  navigationController
                }
            }
            return navigationViewController
        }
    }
    
    public func openDetail(id: String){
        let detailViewController  = DetailViewController()
        detailViewController.idLogin = id
        detailViewController.viewModel = DetailGitViewModel(factory: ServiceFactory())

        if let rootViewController = getRootViewController() {
            rootViewController.pushViewController(detailViewController, animated: true)
        }

        if let spy = spy {
            spy.detailViewControllerOpened()
        }
    }
    
}
