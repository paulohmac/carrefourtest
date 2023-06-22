//
//  DetailViewModel.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 20/06/23.
//

import UIKit


protocol DetailViewModel {
    var user : String {get}

    var repos : [Repo]? {get}

    var userDetail: Login? {get}

    func getUserDetail(user : String) async
    
    func getUserRepos(user : String) async
    
}

extension DetailViewModel{
    
    static func getViewModel()->DetailViewModel{
        return DetailGitViewModel(factory: ServiceFactory())
    }
}

class DetailGitViewModel : DetailViewModel{

    var repos : [Repo]?

    private let service : GitHubService
    
    internal var user = ""
    
    private var loading : Bool = false
    
    var userDetail: Login?
    
    init(factory : Factory) {
        self.service = factory.getService()
    }
    
    func getUserDetail(user : String) async{
        do{
            let ret = try await service.perfomrRequest(action: .detail(id: user))
            if case let .success(data) = ret,let lgn = data as? Login  {
                userDetail = lgn
            }else if case let .error(error) = ret {
                showError(error: error.localizedDescription)
            }
       }catch {
           showError(error: error.localizedDescription)
        }
    }
    
    func getUserRepos(user : String) async{
        do{
            let ret = try await service.perfomrRequest(action: .repos(user: user))
            if case let .success(data) = ret,let lgn = data as? [Repo]  {
                repos = lgn
            }else if case let .error(error) = ret {
                showError(error: error.localizedDescription)
            }
       }catch {
           showError(error: error.localizedDescription)
        }
    }
    
    public func showError(error : String){
        print(error)
    }
}
