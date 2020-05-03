//
//  DetailVillainViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 02/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class DetailVillainViewController: UIViewController , EditPowerVillainControllerDelegate {
    
    
    @IBOutlet weak var imageVillain: UIImageView!
    @IBOutlet weak var imagePower: UIImageView!
    @IBOutlet weak var battles: UIStackView!
    @IBOutlet weak var villainDescription: UITextView!
    
    private var villain: Villain?
    
    convenience init(withVillain villain: Villain) {
        self.init()
        self.villain = villain
        self.title = villain.nombre
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupBattle()
    }
    
    // MARK: Setup
    func setupData() {
        self.imageVillain.image = UIImage.init(named: self.villain?.imagen ?? "")
        self.imagePower.image = UIImage.init(named: "ic_stars_\(self.villain?.poder ?? 0)")
        self.villainDescription.text = villain?.descripcion
    }
    
    func setupBattle() {
        let battlesInVillain = self.villain?.battle
        print("/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/")
        battlesInVillain?.forEach { battleDone in
            if let battleView = Bundle.main.loadNibNamed("BattleView", owner: nil, options: nil)?.first as? BattleView {
                battleView.translatesAutoresizingMaskIntoConstraints = false
                battleView.widthAnchor.constraint(equalToConstant: battles.frame.height).isActive = true
                let eachBattle = battleDone.self as? Battle
                battleView.battleName.text = eachBattle?.adversaryTwo?.nombre
                if eachBattle?.adversaryTwo?.nombre == eachBattle?.winner {
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
        guard let villainToSend = self.villain else {
            return
        }
        let editVillainPower = EditPowerVillainViewController.init(withVillain: villainToSend)
        editVillainPower.delegate = self
        let navigationController = UINavigationController.init(rootViewController: editVillainPower)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    //MARK: Delegates
    func didPowerVillainChange() {
        //navigationController?.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
}

