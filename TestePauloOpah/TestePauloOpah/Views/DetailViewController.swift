//
//  DetailViewController.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit
import Stevia
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {
    public var idLogin : String = ""
    
    var safeArea: UILayoutGuide!
    
    public var viewModel : DetailViewModel?

    let activityView = UIActivityIndicatorView(style: .large)

    let headerStack = UIStackView ()
    
    let tableView = UITableView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        
        view.backgroundColor = .white
        loadData()
       
        setupTableView()
        setupHeader()
        
        headerStack.axis = .vertical
        headerStack.alignment = .leading

        headerStack.backgroundColor = UIColor.blue
        tableView.backgroundColor = UIColor.green
    }

    func setupHeader(){
        view.addSubview(headerStack)
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        headerStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerStack.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        headerStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
      }
    
    func loadData(){
        Task {
            activityIndicatorShould(apper: true)
            await viewModel?.getUserDetail(user: idLogin)
            activityIndicatorShould(apper: false)
            configUserData()
        }
        Task {
            activityIndicatorShould(apper: true)
            await viewModel?.getUserDetail(user: idLogin)
            activityIndicatorShould(apper: false)
            configUserData()
        }
    }
    
    private func activityIndicatorShould(apper: Bool){
        if apper {
            activityView.center = self.view.center
            self.view.addSubview(activityView)
            activityView.startAnimating()
        }else{
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        }
    }
    
    func configUserData(){

        let namelbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        namelbl.center = CGPoint(x: 160, y: 285)
        namelbl.textAlignment = .center
        namelbl.text = "Login:" + idLogin
        headerStack.addArrangedSubview(namelbl)

        
        let urllbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        urllbl.center = CGPoint(x: 160, y: 285)
        urllbl.textAlignment = .center
        urllbl.text = "Url:" +  (viewModel?.userDetail?.url ?? "")
        headerStack.addArrangedSubview(urllbl)

        let avatar = UIImage()
        let imageView = UIImageView(image: avatar)
        let downloadURL = URL(string: viewModel?.userDetail?.avatar_url ?? "")!
        imageView.af.setImage(withURL: downloadURL)
        headerStack.addArrangedSubview(imageView)

    }
}


extension DetailViewController : UITableViewDataSource, UITableViewDelegate{
   
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return viewModel.getTotalLogins()
      return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = "jiban"
    return cell
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        viewModel.openDetail(id: "/(viewModel.getLogin(position: indexPath.row).login)")
    }
}
