//
//  RepositoryDetailsVC.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//

import UIKit

class RepositoryDetailsVC: UIViewController {
    @IBOutlet var tableView: BaseTableView!
    
    private var repository : Repository?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = repository?.name
        tableView.registerCells(RepoInfoTableViewCell.self)
        // Do any additional setup after loading the view.
    }


}

extension RepositoryDetailsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoInfoTableViewCell") as! RepoInfoTableViewCell
        cell.data = repository
        return cell
        
    }
    
    
    
    
}
extension RepositoryDetailsVC{
    static func instance(repo : Repository?) -> RepositoryDetailsVC{
        let controller: RepositoryDetailsVC = UIViewController.load()
        controller.repository = repo
        return controller
    }
}
