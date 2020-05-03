//
//  DetailHeroViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 01/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class DetailHeroViewController: UIViewController, EditPowerHeroControllerDelegate {
    
    
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var imagePower: UIImageView!
    @IBOutlet weak var battles: UIStackView!
    @IBOutlet weak var heroDescription: UITextView!
    
    private var hero: Hero?
    
    convenience init(withHero hero: Hero) {
        self.init()
        self.hero = hero
        self.title = hero.nombre
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupBattle()
    }
    
    // MARK: Setup
    func setupData() {
        self.imageHero.image = UIImage.init(named: self.hero?.imagen ?? "")
        self.imagePower.image = UIImage.init(named: "ic_stars_\(self.hero?.poder ?? 0)")
        self.heroDescription.text = hero?.descripcion
    }
    
    func setupBattle() {
        let battlesInHero = self.hero?.battle
        print("/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/")
        battlesInHero?.forEach { battleDone in
            if let battleView = Bundle.main.loadNibNamed("BattleView", owner: nil, options: nil)?.first as? BattleView {
                battleView.translatesAutoresizingMaskIntoConstraints = false
                battleView.widthAnchor.constraint(equalToConstant: battles.frame.height).isActive = true
                let eachBattle = battleDone.self as? Battle
                print("Batalla: \(eachBattle?.id ?? 0)")
                battleView.battleName.text = "Batalla: \(eachBattle?.id ?? 0)"
                if eachBattle?.adversaryOne?.nombre == eachBattle?.winner {
                    battleView.backgroundColor = .red
                } else {
                    battleView.backgroundColor = .blue
                }
                battles.addArrangedSubview(battleView)
            }
        }
    }
    
    //MARK: IBActions
    
    
    @IBAction func PowerChange(_ sender: Any) {
        guard let heroToSend = self.hero else {
            return
        }
        let editHeroPower = EditPowerHeroViewController.init(withHero: heroToSend)
        editHeroPower.delegate = self
        let navigationController = UINavigationController.init(rootViewController: editHeroPower)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    //MARK: Delegates
    func didPowerHeroChange() {
        navigationController?.popViewController(animated: true)
    }
    
}
