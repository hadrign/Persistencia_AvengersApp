//
//  HeroTableViewCell.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 30/04/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var power: UIImageView!
    
    private var hero: Hero?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        imageHero.layer.cornerRadius = 8
        
    }
    
    
    func setHero(_ hero: Hero) {
        self.hero = hero
        self.imageHero.image = UIImage.init(named: hero.imagen ?? "")
        self.nameHero.text = hero.nombre
        self.power.image = UIImage.init(named: "ic_stars_\(hero.poder)")
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
