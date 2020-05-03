//
//  EditPowerHeroViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 02/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

protocol EditPowerHeroControllerDelegate {
    func didPowerHeroChange()
}

class EditPowerHeroViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var powerBtn: UIButton!
    
    private var hero: Hero?
    var delegate: EditPowerHeroControllerDelegate?
    private var dataProvider = DataProvider()
    
    convenience init(withHero hero: Hero) {
        self.init()
        self.hero = hero
        self.title = hero.nombre
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage.init(named: self.hero?.imagen ?? "")
        self.powerBtn.setImage(UIImage.init(named: "ic_stars_\(self.hero?.poder ?? 0)"), for: .normal)
    }


    //MARK: IBActions
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func editingPower(_ sender: Any) {
        if self.hero?.poder == 5 {
            self.hero?.poder = 0
            self.powerBtn.setImage(UIImage.init(named: "ic_stars_\(self.hero?.poder ?? 0)"), for: .normal)
        } else {
            self.hero?.poder+=1
            self.powerBtn.setImage(UIImage.init(named: "ic_stars_\(self.hero?.poder ?? 0)"), for: .normal)
        }
    }
    
    
    @IBAction func acceptAction(_ sender: Any) {
        let heroData = dataProvider.loadHero(name: self.hero?.nombre ?? "")
        heroData.first?.poder = Int16(self.hero?.poder ?? 0)
        guard let hero = heroData.first else {
            return
        }
        dataProvider.saveHero(hero)
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.delegate?.didPowerHeroChange()
        let noteName = Notification.Name(rawValue: "DidPowerHeroUpdated")
        NotificationCenter.default.post(name: noteName, object: nil)
    }
}
