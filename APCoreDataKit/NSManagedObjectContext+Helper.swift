//
//  Created by Aleksandrs Proskurins
//
//  License
//  Copyright © 2016 Aleksandrs Proskurins
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import CoreData

public extension NSManagedObjectContext {
    
    public func insert<T : NSManagedObject>(_ entity: T.Type) -> T {
        let entityName = entity.entityName
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into:self) as! T
    }
    
    public func performFetch<T: NSManagedObject>(request: NSFetchRequest<NSFetchRequestResult>) throws -> [T] {

        var results = [AnyObject]()
        var caughtError: NSError?
        
        performAndWait {
            do {
                results = try self.fetch(request)
            }
            catch {
                caughtError = error as NSError
            }
        }
        
        guard caughtError == nil else {
            throw caughtError!
        }
        
        return results as! [T]
    }
    
    public func saveContext(andWait wait: Bool = true, success: (() -> Void)? = nil, failure: ((NSError) -> Void)? = nil) {
        
        let saveBlock = {
            
            guard self.hasChanges else {
                return
            }
            
            do {
                try self.save()
                success?()
            }
            catch {
                failure?(error as NSError)
            }
        }
        wait ? performAndWait(saveBlock) : perform(saveBlock)
    }
    
    public func delete<T: NSManagedObject>(objects: [T]) {
        
        guard objects.count != 0 else { return }
        
        self.performAndWait {
            for each in objects {
                self.delete(each)
            }
        }
    }
    
    public func delete<T : NSManagedObject>(entity: T.Type) throws {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try self.persistentStoreCoordinator!.execute(deleteRequest, with: self)
        } catch let error as NSError {
            throw error
        }
    }
}
