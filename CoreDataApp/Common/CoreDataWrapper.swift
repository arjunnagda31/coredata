//
//  CoreDataWrapper.swift
//  CoreDataApp
//
//  Created by Mac on 7/10/18.
//  Copyright © 2018 Global Garner. All rights reserved.
//

import UIKit
import CoreData

class CoreDataWrapper: NSObject {

    
    class func insertData(name : String, mobile:String, dob : Date, imageData: Data, Success :@escaping(_ status:Bool, _ errorDes: String)->Void) {
        
        let managedContext = appDelegateInstance.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(name, forKeyPath: "name")
        user.setValue(mobile, forKey: "mobile")
        user.setValue(dob, forKey: "dob")
        user.setValue(imageData, forKey: "imageData")
        
        do {
            try managedContext.save()
            Success(true,"")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            Success(false,error.description)
        }
        
    }
    
    class func updateData( dctEdit:[String : Any], name : String, mobile:String, dob : Date, imageData: Data, Success :@escaping(_ status:Bool, _ errorDes: String)-> Void) {

        let managedContext = appDelegateInstance.persistentContainer.viewContext
        
        if let strnm = dctEdit["name"] as? String {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
            let predicate = NSPredicate(format: "name = '\(strnm)'")
            fetchRequest.predicate = predicate
            do
            {
                let test = try managedContext.fetch(fetchRequest)
                
               // if let strnm = dctEdit["tag"] as? Int {
                    
                    let objectUpdate = test[0] as! NSManagedObject
                    objectUpdate.setValue(name, forKey: "name")
                    objectUpdate.setValue(mobile, forKey: "mobile")
                    objectUpdate.setValue(dob, forKey: "dob")
                    objectUpdate.setValue(imageData, forKey: "imageData")

                    do{
                        try managedContext.save()
                        Success(true,"")

                    }
                    catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                        Success(false,error.description)
                    }
                    
                //}
                
                //}
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                Success(false,error.description)
            }
        }
    }
    
    class func getData(Success :@escaping(_ objpeople:[NSManagedObject], _ status:Bool, _ errorDes: String)-> Void) {
        
        let managedContext = appDelegateInstance.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let  people : [NSManagedObject] = try managedContext.fetch(fetchRequest)
            
            Success(people,true,"")
            
        } catch let error as NSError {
            Success([],false,error.description)
        }
    }

    class func deleteData( dctEdit:[String : Any], Success :@escaping(_ status:Bool, _ errorDes: String)-> Void) {
        
        let managedContext = appDelegateInstance.persistentContainer.viewContext
        
        if let strnm = dctEdit["name"] as? String {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
            let predicate = NSPredicate(format: "name = '\(strnm)'")
            fetchRequest.predicate = predicate
            do
            {
                let test = try managedContext.fetch(fetchRequest)

                let objectUpdate = test[0] as! NSManagedObject
                managedContext.delete(objectUpdate)
                
                do{
                    try managedContext.save()
                    Success(true,"")
                    
                }
                catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    Success(false,error.description)
                }
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                Success(false,error.description)
            }
        }
    }
    
    
}
