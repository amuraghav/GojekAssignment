//
//  RepositoryVC.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import UIKit

class RepositoryVC: UIViewController {
    @IBOutlet var tableView: BaseTableView!
    private let refreshControl = UIRefreshControl()
    lazy var viewModel: RepositoryViewModel = {
        RepositoryViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Github Trends"
        tableView.registerCells(RepoTableViewCell.self)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshGitRepositry(_:)), for: .valueChanged)
        viewModel.fetchData()
        addListener()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if(viewModel.repositoryList.value == nil || viewModel.repositoryList.value?.count == 0){
            
            viewModel.getRepository()
        }
        
    }
    
    @objc private func refreshGitRepositry(_ sender: Any) {
        viewModel.getRepository()
    }

    
    func addListener() {
        
        viewModel.showHUD.bind { [unowned self](show) in
            
            self.showHUD(show)
        }
        viewModel.showAlert.bind { [unowned self](message) in
   
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.view.layoutIfNeeded()
                
            self.showAlertMesssage(message: message, onCompletion: nil)
            }
        }
        viewModel.neworkError.bind {[unowned self](isNetworkError) in
            DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
             showNetworkError()
            }
        }
      
        viewModel.repositoryList.bind { [unowned self](list) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }

        }
        
    }
    
    func showNetworkError() {
        let networkVC = NoInternetVC.instance()
        let navigationRepositoryVC = UINavigationController(rootViewController: networkVC)
        navigationRepositoryVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navigationRepositoryVC, animated: true, completion: nil)
    }

}

extension RepositoryVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repositoryList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell") as? RepoTableViewCell else{ return UITableViewCell()}
        cell.data = viewModel.repositoryList.value?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoObj = viewModel.repositoryList.value?[indexPath.row]
        let detailVC = RepositoryDetailsVC.instance(repo: repoObj)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    
}

extension RepositoryVC{
    
    static func instance() -> RepositoryVC{
        let controller: RepositoryVC = UIViewController.load()
        return controller
    }
}
