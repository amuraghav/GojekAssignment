//
//  CoreDataManager.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//

import Foundation
protocol GithubRepository {
    
    func saveRepository(repo : RepositoryItem)
    func getAllRepository() -> [Repository]?
    func deleteAllRepository()
    
}

struct CoreDataManager : GithubRepository {
    func saveRepository(repo: RepositoryItem) {
        let repositoryMO = RepositoryManagedObject(context: PersistenceService.shared.context)
        repositoryMO.author = repo.owner?.login
        repositoryMO.name = repo.name
        repositoryMO.avatar = repo.owner?.avatarURL
        repositoryMO.url = repo.htmlURL
        repositoryMO.welcomeDescription = repo.itemDescription
        repositoryMO.language = repo.language
        repositoryMO.stars = repo.stargazersCount as NSNumber?
        repositoryMO.forks = repo.forksCount as NSNumber?
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
