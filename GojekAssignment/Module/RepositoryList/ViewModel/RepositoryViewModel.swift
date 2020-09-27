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
        let urlString = baseUrl + "repositories"
        self.showHUD.value = true
        ServiceManager.shared.performRequest(request: APIRequest(url: urlString)) {[weak self] (result : Result< [Repository] , NetworkError>) in
          
            switch result {
            case .success(let response):
                self?.deleteChache()
                self?.saveAndFetch(list: response)
//               print(response)
            case .failure(let error) :
                self?.showHUD.value = false
            if(error == .noInternet){self?.neworkError.value = true} else {self?.showAlert.value = error.localizedDescription}
            }
            
        }

    }
    
    func saveAndFetch(list : [Repository]){
        let semaphore = DispatchSemaphore(value: 0)
        let dispatchQueue = DispatchQueue.global()
       
        dispatchQueue.async{
            semaphore.signal()
            self.saveRepository(list)
            semaphore.signal()
            semaphore.wait()
            self.fetchData()
            semaphore.signal()
            semaphore.wait()
        }
        semaphore.signal()
         self.showHUD.value = false
    }
    
    func fetchData(){
        repositoryList.value =  _coreDataManager.getAllRepository()
    }
    
    func deleteChache(){
        self._coreDataManager.deleteAllRepository()
    }
    
    func saveRepository(_ list : [Repository]){
        list.forEach { (repoObj) in
            self._coreDataManager.saveRepository(repo: repoObj)
        }
    }
    
}
