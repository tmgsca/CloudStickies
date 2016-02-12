//
//  StickyNote.swift
//  CloudStickies
//
//  Created by Thiago on 12/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Foundation
import RealmSwift

class StickyNote: Object {
    
    dynamic var id = 0
    dynamic var content = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension StickyNote {
    
    class func all() -> Results<StickyNote> {
        
        let realm = try! Realm()
        
        return realm.objects(StickyNote)
    }
    
    class func byId(id: Int) -> StickyNote? {
        
        let realm = try! Realm()
        
        return realm.objectForPrimaryKey(StickyNote.self, key: id)
    }
    
    class func save(note: StickyNote) {
        
        let realm = try! Realm()
        
        try! realm.write { () -> Void in
            
            realm.add(note, update: true)
        }
    }
    
    class func delete(note: StickyNote) {
        
        let realm = try! Realm()
        
        try! realm.write { () -> Void in
            
            realm.delete(note)
        }
        
    }
}