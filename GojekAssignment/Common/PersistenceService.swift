//
//  PersistenceService.swift
//  GojekAssignment
//
//  Created by Pankaj Raghav on 27/09/20.
//

import Foundation
import CoreData
final class PersistenceService {
    private init() {}
    static let shared = PersistenceService()
   lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
   
        let container = NSPersistentContainer(name: "GojekAssignment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManageObject<T:NSManagedObject>(manageObject : T.Type) -> [T]?
    {
        do{
            guard let result = try PersistenceService.shared.context.fetch(manageObject.fetchRequest()) as? [T] else{ return nil}
            return result
        }
        catch(let error){
            debugPrint(error)
        }
        return nil
    }
}
