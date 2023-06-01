//
//  MainViewController.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]
    var safeArea: UILayoutGuide!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
      }
}

 extension MainViewController {
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return characters.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
     cell.textLabel?.text = characters[indexPath.row]
     return cell
   }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         MainCoordinator.getInstance().openDetail(id: "10")
     }
}

