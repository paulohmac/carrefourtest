//
//  ServiceFactory.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 01/06/23.
//

import UIKit


protocol Factory {
    func getService()->GitHubService
}

class ServiceFactory : Factory{
    
    func getService() -> GitHubService {
        return GitHubHttpService()
    }
    
}
