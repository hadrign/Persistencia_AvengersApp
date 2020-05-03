//
//  DataBase.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 25/04/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit
import CoreData

class DataBase {
    // MARK: Properties
    private let entityHero = "Hero"
    private let entityHeroName = "nombre"
    private let entityHeroPower = "poder"
    private let entityHeroImage = "imagen"
    private let entityHeroDescription = "Descripcion"
    private let entityVillain = "Villain"
    private let entityVillainName = "nombre"
    private let entityVillainPower = "poder"
    private let entityVillainImage = "imagen"
    private let entityVillainDescription = "Descripcion"
    private let entityRelationshipBattle = "battle"
    private let entityBattle = "Battle"
    private let entityBattleID = "id"
    private let entityBattleWinner = "winner"
    private let enityBattleAdversaryOne = "adversaryOne"
    private let entityBattleAdversaryTwo = "adversaryTwo"
    
    // MARK: - Managed Object Context
    private func context() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
         
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Database methods
    //Creamos entity de cualquier clase
    func createEntity(of entity: String) -> NSManagedObject? {
        guard let contexMOB = context(), let entityCreated = NSEntityDescription.entity(forEntityName: entity, in: contexMOB) else {
            return nil
        }
        if (entity.elementsEqual(entityHero)) {
            return Hero(entity: entityCreated, insertInto: context())
        } else if (entity.elementsEqual(entityVillain)) {
            return Villain(entity: entityCreated, insertInto: context())
        } else {
            return Battle(entity: entityCreated, insertInto: context())
        }
    }
    
    //Función apra guardar los cambion en entidades de cualquier tipo
    func persist(_ entity: Any) {
        guard let contextMOB = context() else {
            return
        }
        
        try? contextMOB.save()
    }
    
    //Función para recuperar todos los elementos de una entidad (Hero, Villain or Battle)
    func fetchAll(of entity: String) -> [NSManagedObject]? {
        return try? context()?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entity)) as? [NSManagedObject]
    }
    
    func feachOneElement(of entity: String, by name: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "\(entityHeroName) = %@", name)
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    func feachOneBattle(by id: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityBattle)
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    func delete(data: [NSManagedObject]) {
        let contextMOB = context()
        data.forEach{ contextMOB?.delete($0) }
        
        print("Deleted objects: \(String(describing: contextMOB?.deletedObjects))")
        try? contextMOB?.save()
    }
}

