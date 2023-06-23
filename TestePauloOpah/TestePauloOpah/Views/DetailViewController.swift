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

class DetailViewController: BaseViewController {
    public var viewModel : DetailViewModel?

    private let headerStack = UIStackView ()
    public var idLogin : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.errorHadling = self
        loadData()
        setupTableView()
        setupHeader()
    }

    private func setupHeader(){
        headerStack.axis = .vertical
        headerStack.alignment = .leading
        headerStack.isLayoutMarginsRelativeArrangement = true
        headerStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        headerStack.distribution = .fill
        view.addSubview(headerStack)

        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        headerStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerStack.bottomAnchor.constraint(equalTo: resultTableView.topAnchor).isActive = true
        headerStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(resultTableView)
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        resultTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        resultTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        resultTableView.dataSource = self
        resultTableView.delegate = self
      }
    
    private func loadData(){
        Task {
            activityIndicatorShould(appear: true)
            await viewModel?.getUserDetail(user: idLogin)
            activityIndicatorShould(appear: false)
            configUserData()
        }
        Task {
            activityIndicatorShould(appear: true)
            await viewModel?.getUserRepos(user: idLogin)
            activityIndicatorShould(appear: false)
            showRepos()
        }
    }

    private func configUserData(){

        let stackViewFrame = UIStackView()
        stackViewFrame.axis = .horizontal
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
        
        let namelbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        namelbl.center = CGPoint(x: 160, y: 285)
        namelbl.textAlignment = .center
        namelbl.text = idLogin
        stackView.addArrangedSubview(namelbl)
        
        let urllbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        urllbl.center = CGPoint(x: 160, y: 285)
        urllbl.textAlignment = .center
        urllbl.text = (viewModel?.userDetail?.url ?? "")
        stackView.addArrangedSubview(urllbl)
        
        let avatar = UIImage()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = avatar
        imageView.layer.cornerRadius = imageView.layer.bounds.height / 2
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 0.5
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.height(50)
        imageView.width(50)

        stackViewFrame.addArrangedSubview(imageView)
        stackViewFrame.addArrangedSubview(stackView)
        headerStack.addArrangedSubview(stackViewFrame)

        let downloadURL = URL(string: viewModel?.userDetail?.avatarUrl ?? "")
        if let downloadURL = downloadURL{
            imageView.af.setImage(withURL: downloadURL)
            headerStack.addArrangedSubview(imageView)
        }

    }
    
    private func showRepos(){
        resultTableView.reloadData()
    }
}

extension DetailViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel?.repos?[indexPath.row].url
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ( viewModel?.repos?[indexPath.row].url ?? "")
        if let urlOpned = URL(string: viewModel?.repos?[indexPath.row].htmlUrl ?? ""), UIApplication.shared.canOpenURL(urlOpned) {
            UIApplication.shared.open(urlOpned)
        }
    }
}
