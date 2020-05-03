//
//  VillanoTableViewCell.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 01/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class VillanoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageVillano: UIImageView!
    @IBOutlet weak var nameVillano: UILabel!
    @IBOutlet weak var power: UIImageView!
    
    private var villano: Villain?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageVillano.layer.cornerRadius = 8
        
    }
    
    
    func setVillano(_ villano: Villain) {
        self.villano = villano
        self.imageVillano.image = UIImage.init(named: villano.imagen ?? "")
        self.nameVillano.text = villano.nombre
        self.power.image = UIImage.init(named: "ic_stars_\(villano.poder)")
    }
}
