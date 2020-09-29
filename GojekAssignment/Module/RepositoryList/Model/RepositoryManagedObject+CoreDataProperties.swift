//
//  RepositoryManagedObject+CoreDataProperties.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//
//

import Foundation
import CoreData


extension RepositoryManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepositoryManagedObject> {
        return NSFetchRequest<RepositoryManagedObject>(entityName: "RepositoryManagedObject")
    }

    @NSManaged public var author: String?
    @NSManaged public var avatar: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var welcomeDescription: String?
    @NSManaged public var language: String?
    @NSManaged public var languageColor: String?
    @NSManaged public var stars: NSNumber?
    @NSManaged public var forks: NSNumber?
    @NSManaged public var currentPeriodStars: NSNumber?
    
    func convertToRepositoryObject() -> Repository{
        
        return Repository(author: self.author, name: self.name, avatar: self.avatar, url: self.url, welcomeDescription: self.welcomeDescription, language: self.language, languageColor: self.languageColor, stars: self.stars as? Int, forks: self.forks as? Int, currentPeriodStars: self.currentPeriodStars as? Int, builtBy: nil)
    }

}
