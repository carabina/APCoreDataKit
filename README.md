# APCoreDataKit
 [![license MIT](https://img.shields.io/cocoapods/l/JSQCoreDataKit.svg)][mitLink]


A lightweight helper library that reduces the boilerplate involved with Core Data setup and work.

## Requirements
* Xcode 8
* Swift 3.0
* iOS 9.0+

## Installation

##### [CocoaPods](http://cocoapods.org). Please use the latest CocoaPods as this framework is using Swift 3  

````ruby
use_frameworks!

pod 'APCoreDataKit'

````

## Usage 

##### Setting up `NSManagedObjectContext` with SQL store type

````swift
let persistentStoreType = PersistentStoreType.SQLite("SQLFileName")
let model = ManagedObjectModel(name: "XcdatamodeldName")   
let moc = NSManagedObjectContext(model: model, storeType: persistentStoreType)
````

##### Setting up `NSManagedObjectContext` with in memory store type

````swift
let persistentStoreType = PersistentStoreType.InMemory
let model = ManagedObjectModel(name: "XcdatamodeldName")   
let moc = NSManagedObjectContext(model: model, storeType: persistentStoreType)
````

##### Creating and inserting `NSManagedObject`

````swift
let entity = moc.createAndInsert(entity: Entity.self)
````

##### Deleting `NSManagedObject`

````swift
let objects: [Entity] = ...
moc.delete(objects: objects)
````

##### Deleting all entities using batch request 

````swift
moc.delete(entity: Entity.self)
````
##### Creating a fetch request for entity  

````swift
let fetchRequest = Entity.entityFetchRequest()
````

##### Executing a fetch request 

````swift
let personArray: [Entity] = try moc.performFetch(request: fetchRequest)
````

##### Saving context 

````swift
moc.saveContext(andWait: true, success: { 
            
}) { (error) in
                
}
````
## License

`APCoreDataKit` is released under an [MIT License][mitLink]. See `LICENSE` for details.

[mitLink]:http://opensource.org/licenses/MIT