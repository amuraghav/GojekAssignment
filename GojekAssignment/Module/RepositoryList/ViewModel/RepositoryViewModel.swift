//
//  RepositoryViewModel.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 26/09/20.
//

import Foundation

class RepositoryViewModel : BaseViewModel{
    var RepositoryList: Bindable<[Repository]?> = Bindable(nil)
    
 // MARK:- GET REPOSITORY FROM API
    
    func getRepository(){
        let urlString = baseUrl + "repositories"
        self.showHUD.value = true
        ServiceManager().performRequest(request: APIRequest(url: urlString)) {[weak self] (result : Result< [Repository] , NetworkError>) in
            self?.showHUD.value = false
            switch result {
            case .success(let response):
                self?.RepositoryList.value = response
               print(response)
            case .failure(let error) :
                print(error)
//                print(error.localizedDescription)
                
            }
            
        }

    }
    
    
}
