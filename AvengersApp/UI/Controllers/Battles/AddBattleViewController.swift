//
//  AddBattleViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 02/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class AddBattleViewController: UIViewController, HerosBattleViewControllerDelegate, VillainsBattleViewControllerDelegate {
    
    
    @IBOutlet weak var battleName: UILabel!
    @IBOutlet weak var addHero: UIButton!
    @IBOutlet weak var addVillain: UIButton!
    @IBOutlet weak var btnFight: UIButton!
    
    var battles: [Battle] = []
    var hero: Hero? = nil
    var villain: Villain? = nil
    private var dataProvider = DataProvider()
    var battleID: Int16 = 0
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addHero.alpha = 0.65
        addHero.setTitle("Añadir Heroe", for: .normal)
        addVillain.alpha = 0.65
        addVillain.setTitle("Añadir Villano", for: .normal)
        btnFight.layer.cornerRadius = 30.0
        btnFight.layer.borderWidth = 1.0
        btnFight.layer.borderColor = UIColor.blue.withAlphaComponent(0.6).cgColor
        setupBattleName()
        
        
        
    }
    
    //MARK: Setup
    
    func setupBattleName() {
        
        self.battles = dataProvider.loadAllBattles()
        self.battleID = self.battles.last?.id ?? 0
        /*self.battles.forEach { battle in
            battleID = battle.id
        }*/
        self.battleID+=1
        self.battleName.text = "Batalla \(self.battleID)"
        
    }
    
    //MARK: IBActions
    
    @IBAction func fireAddHero(_ sender: Any) {
        let herosList = HerosBattleViewController.init()
        herosList.delegate = self
        self.navigationController?.pushViewController(herosList, animated: true)
    }
    
    @IBAction func fireAddVillain(_ sender: Any) {
        let villainsList = VillainsBattleViewController.init()
        villainsList.delegate = self
        self.navigationController?.pushViewController(villainsList, animated: true)
    }
    
    @IBAction func fireBattle(_ sender: Any) {
        let randomInt = Int16.random(in: 1 ... 2)
        let currentBattle = dataProvider.createBattle()
        currentBattle?.id = self.battleID
        currentBattle?.adversaryOne = self.hero
        currentBattle?.adversaryTwo = self.villain
        if randomInt == 1 {
            currentBattle?.winner = self.hero?.nombre
        } else {
            currentBattle?.winner = self.villain?.nombre
        }
        guard let battleToSave = currentBattle else {
            return
        }
        dataProvider.saveBattle(battleToSave)
        let noteName = Notification.Name(rawValue: "DidBattleUpdated")
        NotificationCenter.default.post(name: noteName, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Delegates
    func didHeroSelected(withHero hero: Hero) {
        self.hero = hero
        addHero.setImage(UIImage.init(named: hero.imagen ?? ""), for: .normal)
        addHero.alpha = 1.0
        addHero.setTitle("", for: .normal)
    }
    
    func didVillainSelected(withVillain villano: Villain) {
        self.villain = villano
        addVillain.setImage(UIImage.init(named: villano.imagen ?? ""), for: .normal)
        addVillain.alpha = 1.0
        addVillain.setTitle("", for: .normal)
    }
    
}
