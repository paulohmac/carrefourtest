//
//  MainViewController.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource  {
    private var sampleTextField = UITextField()
    private lazy var viewModel = MainGitHubViewModel(factory: ServiceFactory())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        viewModel.errorHadling = self
        setupEditText()
        setupTableView()
        loadData()
    }

    private func loadData(){
        Task {
            activityIndicatorShould(appear: true)
            await viewModel.listUser()
            tableView.reloadData()
            activityIndicatorShould(appear: false)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: sampleTextField.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
      }
    
    private func setupEditText(){
        sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        sampleTextField.placeholder = "Enter text here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self

        sampleTextField.top(8)
        sampleTextField.right(16)
        sampleTextField.left(16)
        self.view.addSubview(sampleTextField)
    }
  
}

 extension MainViewController {
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.getTotalLogins()
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       cell.textLabel?.text = viewModel.getLogin(position: indexPath.row)?.login
     return cell
   }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         viewModel.openDetail(id: viewModel.getLogin(position: indexPath.row)?.login ?? "")
     }
}

extension MainViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if updatedString?.count ?? 0 >= 5 && updatedString != "" {
            Task {
                await viewModel.findLogins(text: updatedString ?? "")
                tableView.reloadData()
            }
        }
        return true
    }
}
