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
 // MARK:- GET REPOSITORY FROM API
    
    func getRepository(){
        let urlString = baseUrl + "repositories"
        self.showHUD.value = true
        ServiceManager().performRequest(request: APIRequest(url: urlString)) {[weak self] (result : Result< [Repository] , NetworkError>) in
            self?.showHUD.value = false
            switch result {
            case .success(let response):
                self?.repositoryList.value = response
//               print(response)
            case .failure(let error) :
            if(error == .noInternet){self?.neworkError.value = true} else {self?.showAlert.value = error.localizedDescription}
            }
            
        }

    }
    
    
}
