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
    private var timer : Timer?
    private var timerSecond = Constants.TIMER_COUNT
    lazy var viewModel: RepositoryViewModel = {
        RepositoryViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    func initialize() {
        self.title = "Github Trends"
        tableView.registerCells(RepoTableViewCell.self)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshGitRepositry(_:)), for: .valueChanged)
        viewModel.fetchData()
        addListener()
        if(viewModel.repositoryList.value == nil || viewModel.repositoryList.value?.count == 0){
            viewModel.getRepository()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timerInit()
       
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        stopTimer()
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
        let networkVC = NoInternetVC.instance(buttonAction: {
            self.viewModel.getRepository()
        })
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
        if let repoObj = viewModel.repositoryList.value?[indexPath.row]{
        let detailVC = RepositoryDetailsVC.instance(repo: repoObj)
        self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension RepositoryVC{
    func timerInit()
    {
        if(timer == nil){
            timerSecond = Constants.TIMER_COUNT
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCode), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc func timerCode() {
        timerSecond -= 1
        if(timerSecond == 0){
            timerSecond = Constants.TIMER_COUNT
            viewModel.getRepository()
        }
    }
    
    func stopTimer() {
        guard (timer != nil) else {
            return
        }
        timer?.invalidate()
        timer = nil
    }
}


extension RepositoryVC{
    
    static func instance() -> RepositoryVC{
        let controller: RepositoryVC = UIViewController.load()
        return controller
    }
}
