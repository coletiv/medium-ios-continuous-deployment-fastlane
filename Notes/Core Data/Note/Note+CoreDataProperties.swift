//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Andre Silva on 16/02/2018.
//  Copyright © 2018 Coletiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {
  
  @nonobjc public class func fetchRequestForEntity() -> NSFetchRequest<Note> {
    return NSFetchRequest<Note>(entityName: "Note")
  }
  
  @nonobjc public class func entityDescriptionForEntity(in context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: "Note", in: context)
  }
  
  
  @NSManaged public var note: String?
  @NSManaged public var title: String?
  
}
