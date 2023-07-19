//
//  MainViewController.swift
//  TestePauloOpah
//
//  Created by Paulo H.M. on 31/05/23.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource  {
    private var searchTextField = UITextField()
    private lazy var viewModel = MainGitHubViewModel(factory: ServiceFactory())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString:"#f6f8fA")
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
            resultTableView.reloadData()
            activityIndicatorShould(appear: false)
        }
    }
    
    private func setupTableView() {
        view.addSubview(resultTableView)
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16).isActive = true
        resultTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        resultTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        resultTableView.dataSource = self
        resultTableView.delegate = self
      }
    
    private func setupEditText(){
        searchTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        searchTextField.placeholder = "Enter github user login"
        searchTextField.font = UIFont.systemFont(ofSize: 15)
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        searchTextField.autocorrectionType = UITextAutocorrectionType.no
        searchTextField.keyboardType = UIKeyboardType.default
        searchTextField.returnKeyType = UIReturnKeyType.done
        searchTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        searchTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        searchTextField.delegate = self
        searchTextField.setDefaultFont()

        searchTextField.top(8)
        searchTextField.right(16)
        searchTextField.left(16)
        self.view.addSubview(searchTextField)
    }
  
}

 extension MainViewController {
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.getTotalLogins()
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       cell.textLabel?.text = viewModel.getLogin(position: indexPath.row)?.login
       cell.textLabel?.setDefaultFont()

     return cell
   }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         viewModel.openDetail(id: (viewModel.getLogin(position: indexPath.row)?.login ?? "" )  )
     }
}

extension MainViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if updatedString?.count ?? 0 >= 5 && updatedString != "" {
            Task {
                await viewModel.findLogins(text: updatedString ?? "")
                resultTableView.reloadData()
            }
        }
        return true
    }
}
