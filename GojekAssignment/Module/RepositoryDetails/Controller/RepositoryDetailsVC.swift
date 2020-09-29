//
//  RepositoryDetailsVC.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//

import UIKit
import WebKit

class RepositoryDetailsVC: UIViewController {
    @IBOutlet var tableView: BaseTableView!
    private var repository : Repository!
    
    lazy var webPageTableViewCell: WebPageTableViewCell = {
        self.tableView.dequeueCell(WebPageTableViewCell.self)
    }()
    
    lazy var repoInfoTableViewcell: RepoInfoTableViewCell = {
        self.tableView.dequeueCell(RepoInfoTableViewCell.self)
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
                
    }
    
     func initialize() {
        
        self.title = repository.name
        tableView.registerCells(RepoInfoTableViewCell.self,WebPageTableViewCell.self)
        repoInfoTableViewcell.data = repository
        if let url = URL(string: repository?.url ?? ""){
        webPageTableViewCell.webView.load(URLRequest(url:url ))
        }
    }

}

extension RepositoryDetailsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        [repoInfoTableViewcell,webPageTableViewCell][indexPath.item]
    }
}
extension RepositoryDetailsVC{
    static func instance(repo : Repository) -> RepositoryDetailsVC{
        let controller: RepositoryDetailsVC = UIViewController.load()
        controller.repository = repo
        return controller
    }
}
