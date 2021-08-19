//
//  NoticeCoreData.swift
//  Stud_MS_CoreData
//
//  Created by Nick patel on 18/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class NoticeCoreData
{
    static let sh = NoticeCoreData()
    
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
    
    func insert_notice(title:String , desc:String , completion: @escaping () -> Void)
    {
        let nts = TBLNOTICE(context: manageObjectContext!)
        
        nts.title = title
        nts.desc = desc
        
        save()
        completion()
        
    }
    
    func fetch_notice() -> [TBLNOTICE] {
        
        let fetchRequest:NSFetchRequest<TBLNOTICE> = TBLNOTICE.fetchRequest()
        
        do {
            let noticeArr = try manageObjectContext?.fetch(fetchRequest)
            return noticeArr!
        }
        catch {
            print(error)
            return [TBLNOTICE]()
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
