//
//  RealmManager.swift
//  Iny
//
//  Created by Deniz Dilbilir on 10/04/2024.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    
    
    func create<ResponseType: Object>(_ object: ResponseType, theError: (RealmError) -> ())
    func fetchAll<ResponseType: Object>(_ object: ResponseType.Type) -> [ResponseType]
    func update<ResponseType: Object>(_ object: ResponseType, with dictionary: [String: Any?], theError: (RealmError) -> ())
    func delete<ResponseType: Object>(_ object: ResponseType, theError: (RealmError) -> ())
}

final class RealmManager: RealmManagerProtocol {
    
    private let realm = try! Realm()
    static let shared = RealmManager()
    
    private init() {
        
    }
    
    func create<ResponseType: Object>(_ object: ResponseType, theError: (RealmError) -> ()) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("creating object error: \(error.localizedDescription)")
            theError(.addFailure)
        }
    }
    
    func fetchAll<ResponseType: Object>(_ object: ResponseType.Type) -> [ResponseType] {
        return Array(realm.objects(ResponseType.self))
    }
    
    func update<ResponseType: Object>(_ object: ResponseType, with dictionary: [String: Any?], theError: (RealmError) -> ()) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
            
        } catch {
            print("Object Updating Error: \(error.localizedDescription)")
            theError(.updateFailure)
        }
    }
    
    func delete<ResponseType: Object>(_ object: ResponseType, theError: (RealmError) -> ()) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Deleting object error : \(error.localizedDescription)")
            theError(.deleteFailure)
        }
    }
}
