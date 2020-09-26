//
//  RepositoryVC.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import UIKit

class RepositoryVC: UIViewController {
    @IBOutlet var tableView: BaseTableView!
    
    lazy var viewModel: RepositoryViewModel = {
        RepositoryViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Github Trends"
        tableView.registerCells(RepoTableViewCell.self)
        addListener()
        viewModel.getRepository()
    }
  
    
    func addListener() {
        
        viewModel.showHUD.bind { [unowned self](show) in
            self.showHUD(show)
        }
        viewModel.showAlert.bind { [unowned self](message) in
            self.showAlertMesssage(message: message, onCompletion: nil)
        }
      
        viewModel.RepositoryList.bind { [unowned self](list) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
         
        }
        
    }

}

extension RepositoryVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.RepositoryList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell") as? RepoTableViewCell else{ return UITableViewCell()}
        cell.data = viewModel.RepositoryList.value?[indexPath.row]
        return cell
    }
    
    
    
    
}

extension RepositoryVC{
    
    static func instance() -> RepositoryVC{
        let controller: RepositoryVC = UIViewController.load()
        return controller
    }
}
