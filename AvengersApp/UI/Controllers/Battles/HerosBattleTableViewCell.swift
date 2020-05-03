//
//  HerosBattleTableViewCell.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 03/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit


class HerosBattleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroPower: UIImageView!
    
    private var hero: Hero?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func setHero(_ hero: Hero) {
        self.hero = hero
        self.imageHero.image = UIImage.init(named: hero.imagen ?? "")
        self.heroName.text = hero.nombre
        self.heroPower.image = UIImage.init(named: "ic_stars_\(hero.poder)")
    }
    
}
