//
//  CoreDataRepoManager.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//


import CoreData
import UIKit

class CoreDataRepository<T: NSManagedObject> {

    // MARK: - Properties.
    var context: NSManagedObjectContext?
    
    // MARK: - Init
    init(context: NSManagedObjectContext? = nil) {
        let appD = UIApplication.shared.delegate as! AppDelegate
        let myContext = appD.persistentContainer.viewContext
        self.context = context ?? myContext
    }
    
    // MARK: - @discardableResult Methods.
    @discardableResult
    func getBatched(fetchOffSet: Int, fetchLimit:Int ) -> [T]? {
        let EntityName = getEntityName(type: T.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        request.fetchOffset = fetchOffSet
        request.fetchLimit = fetchLimit
        let objects = try? context!.fetch(request) as? [T]
        return objects
    }
    
    @discardableResult
    func getAll() -> [T]? {
        let EntityName = getEntityName(type: T.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        let objects = try? context!.fetch(request) as? [T]
        return objects
    }
    
    @discardableResult
    func getCount() -> Int? {
        let EntityName = getEntityName(type: T.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        request.resultType = .countResultType
        let count = try? context!.count(for: request)
        return count
    }
    
    @discardableResult
    func register(value: T) -> T?{
        var result = false
        do {
            try context!.save()
            result = true
        } catch _ as NSError {
         result = false
        }
        return result == true ? value : nil
    }
    
    @discardableResult
    func deleteAll() -> [T]? {
           let EntityName = getEntityName(type: T.self)
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
           let objects = try? context!.fetch(request) as? [T]
            for item in objects ?? [] {
                context!.delete(item)
            }
            try? context?.save()
           return objects
    }
    
    @discardableResult
    func delete(with: String) -> [T]? {
           let EntityName = getEntityName(type: T.self)
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
           request.predicate = NSPredicate(format: with)
           let objects = try? context!.fetch(request) as? [T]
            for item in objects ?? [] {
                context!.delete(item)
            }
            try? context?.save()
           return objects
    }
}

//MARK: - Private Methods.
extension CoreDataRepository {
    private func getEntityName<T>(type: T.Type)-> String {
        let FullName = String(describing: type)
        let splitName = FullName.split(separator: ".")
        return  splitName.count > 1 ?  splitName[0].base : FullName
    }
}
