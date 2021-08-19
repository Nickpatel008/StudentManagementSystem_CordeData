//
//  CoreDataHandler.swift
//  Stud_MS_CoreData
//
//  Created by Nick patel on 17/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler {
    
    static let shared = CoreDataHandler()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let manageObjectContext : NSManagedObjectContext?
    
    private init()
    {
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save()
    {
        appDelegate.saveContext()
    }
    
    func insert(spid:Int , name:String , course:String , password:String , completion: @escaping () -> Void)
    {
        let stud = TBLSTUDENT(context: manageObjectContext!)
        stud.spid = Int32(spid)
        stud.name = name
        stud.course = course
        stud.password = password
        
        save()
        completion()
        
    }
    
    func fetch() -> [TBLSTUDENT] {
        
        let fetchRequest:NSFetchRequest<TBLSTUDENT> = TBLSTUDENT.fetchRequest()
       
        do {
            let studArr = try manageObjectContext?.fetch(fetchRequest)
            return studArr!
        }
        catch {
            print(error)
            return [TBLSTUDENT]()
        }
        
    }
    
    func delete(stud:TBLSTUDENT , complition: @escaping () -> Void)
    {
        manageObjectContext!.delete(stud)
        
        save()
        complition()
    }
    
    func update(stud:TBLSTUDENT , spid:Int , name:String , course:String , password:String , completion: @escaping () -> Void)
    {
        stud.spid = Int32(spid)
        stud.name = name
        stud.course = course
        stud.password = password
        
        save()
        completion()
        
    }
    
}
