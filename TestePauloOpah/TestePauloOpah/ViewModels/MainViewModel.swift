//
//  MainViewModel.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit

protocol MainViewModel{

    func listUser() async

    var users : [Login] {get}

    func getTotalLogins()->Int

    func getLogin(position : Int)->Login

    func findLogins(text : String) async
    
    func openDetail(id : String)
}

class MainGitHubViewModel{
    private let service : GitHubService
    
    private var users = [Login]()
    
    private var loading : Bool = false
    
    init(factory : Factory) {
        self.service = factory.getService()
    }
    
    func listUser() async{
        do{
            let ret = try await service.perfomrRequest(action: .list)
            if case let .sucess(data) = ret,let logins = data as? [Login]  {
                users = logins
            }else if case let .error(error) = ret {
                showError(error: error.localizedDescription)
            }
       }catch {
           showError(error: error.localizedDescription)
        }
    }

    func findLogins(text : String) async{
        do{
            let ret = try await service.perfomrRequest(action: .search(param: text))
            if case let .sucess(data) = ret,let logins = data as? SearchResult  {
                users = logins.items
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
    
    public func getTotalLogins()->Int{
        return users.count
    }

    public func getLogin(position : Int)->Login{
        return users[position]
    }

    
    public func openDetail(id : String){
        MainCoordinator.instance.openDetail(id: id)
    }
    
}
