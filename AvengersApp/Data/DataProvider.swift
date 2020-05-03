//
//  DataProvider.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 25/04/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import Foundation

class DataProvider {
    private var database: DataBase? = nil
    
    private let heroEntity = "Hero"
    private let villainEntity = "Villain"
    private let battleEntity = "Battle"
    
    init() {
        database = DataBase();
    }
    
    deinit {
        database = nil
    }
    
    func createHero() -> Hero? {
        return database?.createEntity(of: heroEntity) as? Hero
    }
    
    func createVillain() -> Villain? {
        return database?.createEntity(of: villainEntity) as? Villain
    }
    
    func createBattle() -> Battle? {
        return database?.createEntity(of: battleEntity) as? Battle
    }
    
    func saveHero(_ hero: Hero) {
        database?.persist(hero)
    }
    
    func saveVillain(_ villain: Villain) {
        database?.persist(villain)
    }
    
    func saveBattle(_ battle: Battle) {
        database?.persist(battle)
    }
    
    func loadAllHeros() -> [Hero] {
        guard let data = database?.fetchAll(of: heroEntity) as? [Hero] else {
            return []
        }
        return data
    }
    
    func loadAllVillains() -> [Villain] {
        guard let data = database?.fetchAll(of: villainEntity) as? [Villain] else {
            return []
        }
        return data
    }
    
    func loadAllBattles() -> [Battle] {
        guard let data = database?.fetchAll(of: battleEntity) as? [Battle] else {
            return []
        }
        return data
    }
    
    func loadHero(name: String) -> [Hero] {
        return database?.feachOneElement(of: heroEntity, by: name) as? [Hero] ?? []
    }
    
    func loadVillain(name: String) -> [Villain] {
        return database?.feachOneElement(of: villainEntity, by: name) as? [Villain] ?? []
    }
    
    func loadBattle(id: String) -> [Battle] {
        return database?.feachOneBattle(by: id) as? [Battle] ?? []
    }
    
    func deleteBattle(_ battle: Battle) {
        database?.delete(data: [battle])
    }
}
