//
//  CoreDataManager.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//

import Foundation
protocol GithubRepository {
    
    func saveRepository(repo : Repository)
    func getAllRepository() -> [Repository]?
    func deleteAllRepository()
    
}

struct CoreDataManager : GithubRepository {
    func saveRepository(repo: Repository) {
            let repositoryMO = RepositoryManagedObject(context: PersistenceService.shared.context)
           repositoryMO.author = repo.author
           repositoryMO.name = repo.name
           repositoryMO.avatar = repo.avatar
           repositoryMO.url = repo.url
           repositoryMO.welcomeDescription = repo.welcomeDescription
           repositoryMO.language = repo.language
           repositoryMO.languageColor = repo.languageColor
           repositoryMO.stars = repo.stars as NSNumber?
           repositoryMO.forks = repo.forks as NSNumber?
           repositoryMO.currentPeriodStars = repo.currentPeriodStars as NSNumber?
           PersistenceService.shared.saveContext() 
    }
    
    func getAllRepository() -> [Repository]? {
        let result = PersistenceService.shared.fetchManageObject(manageObject: RepositoryManagedObject.self)
        var repoArray : [Repository] = []
        result?.forEach({ (repositoryMO) in
            repoArray.append(repositoryMO.convertToRepositoryObject())
        })
        return repoArray
    }
    
    func deleteAllRepository() {
        guard let fetchResult = PersistenceService.shared.fetchManageObject(manageObject: RepositoryManagedObject.self) else{ return  }
        fetchResult.forEach({ (repositoryMO) in
            PersistenceService.shared.context.delete(repositoryMO)
            PersistenceService.shared.saveContext()
        })
       
        
    }
    

}
