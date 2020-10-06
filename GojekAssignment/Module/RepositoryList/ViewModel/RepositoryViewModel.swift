//
//  RepositoryViewModel.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import Foundation

class RepositoryViewModel : BaseViewModel{
    var repositoryList: Bindable<[Repository]?> = Bindable(nil)
    var neworkError: Bindable<Bool> = Bindable(false)
    private let _coreDataManager = CoreDataManager()
 // MARK:- GET REPOSITORY FROM API
    
    func getRepository(){
        let urlString = Constants.Base_Url + Constants.Api_EndPoint
        self.showHUD.value = true
        ServiceManager.shared.performRequest(request: APIRequest(url: urlString)) {[weak self] (result : Result< RepositoryResponse , NetworkError>) in
          
            switch result {
            case .success(let response):
                if let repoList = response.items{
                    self?.saveAndFetch(list: repoList)
                }
//               print(response)
            case .failure(let error) :
                self?.showHUD.value = false
            if(error == .noInternet){self?.neworkError.value = true} else {self?.showAlert.value = error.localizedDescription}
            }
            
        }

    }
    
    func saveAndFetch(list : [RepositoryItem]){
       let operationQueue = OperationQueue()
        let deleteOperation = BlockOperation {[weak self] in
            self?.deleteChache()
        }
        let saveOperation = BlockOperation {[weak self] in
            self?.saveRepository(list)
        }
        let fetchOperation = BlockOperation {[weak self] in
            self?.fetchData()
        }
        saveOperation.addDependency(deleteOperation)
        fetchOperation.addDependency(saveOperation)
        
        operationQueue.addOperation(deleteOperation)
        operationQueue.addOperation(saveOperation)
        operationQueue.addOperation(fetchOperation)
        
        fetchOperation.completionBlock = {
            DispatchQueue.main.async { [weak self] in
                self?.showHUD.value = false
            }
         
        }
        
    }
    
    func fetchData(){
        repositoryList.value =  _coreDataManager.getAllRepository()
    }
    
    func deleteChache(){
        self._coreDataManager.deleteAllRepository()
    }
    
    func saveRepository(_ list : [RepositoryItem]){
        list.forEach { [weak self] (repoObj) in
            self?._coreDataManager.saveRepository(repo: repoObj)
        }
    }
    
}



