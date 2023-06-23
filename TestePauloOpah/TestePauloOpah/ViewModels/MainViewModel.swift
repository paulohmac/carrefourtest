//
//  MainViewModel.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit

protocol MainViewModel{

    func listUser() async

    var users : [Login]? {get}

    var errorHadling: ErrorHandling? { get set }

    func getTotalLogins()->Int

    func getLogin(position : Int)->Login?

    func findLogins(text : String) async
    
    func openDetail(id : String)
    
    init(factory : Factory)
    
    
}

class MainGitHubViewModel : MainViewModel{
    var errorHadling: ErrorHandling?
    
    
    private let service : GitHubService

    internal var users : [Login]?  
    
    private var loading : Bool = false
    
    required init(factory : Factory) {
        self.service = factory.getService()
    }
    
    func listUser() async{
        do{
            let ret = try await service.perfomrRequest(action: .list)
            if case let .success(data) = ret,let logins = data as? [Login]  {
                users = logins
            }else if case let .error(error) = ret {
                showError(error: error)
            }
       }catch {
           showError(error: error)
        }
    }

    func findLogins(text : String) async{
        do{
            let ret = try await service.perfomrRequest(action: .search(param: text))
            if case let .success(data) = ret,let logins = data as? SearchResult  {
                users = logins.items
            }else if case let .error(error) = ret {
                showError(error: error)
            }
       }catch {
           showError(error: error)
        }
    }
    
    public func showError(error : Error){
        errorHadling?.showError(msg: error)
        print(error)
    }
    
    public func getTotalLogins()->Int{
        return users?.count ?? 0
    }

    public func getLogin(position : Int)->Login?{
        if ((users?.count ?? 0)-1 ) >= position{
            return users?[position]
        }else{
            return nil
        }
    }

    public func openDetail(id : String){
        MainCoordinator.getInstance().openDetail(id: id)
    }
    
}
