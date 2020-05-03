//
//  VillainsBattleTableViewCell.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 03/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class VillainsBattleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageVillain: UIImageView!
    @IBOutlet weak var villainName: UILabel!
    @IBOutlet weak var villainPower: UIImageView!
    
    private var villano: Villain?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func setVillano(_ villano: Villain) {
        self.villano = villano
        self.imageVillain.image = UIImage.init(named: villano.imagen ?? "")
        self.villainName.text = villano.nombre
        self.villainPower.image = UIImage.init(named: "ic_stars_\(villano.poder)")
    }
    
}
