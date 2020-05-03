//
//  BattleTableViewCell.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 02/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class BattleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var oponenteUno: UIImageView!
    @IBOutlet weak var OponenteDos: UIImageView!
    @IBOutlet weak var battleID: UILabel!
    
    private var battle: Battle?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        oponenteUno.layer.cornerRadius = 2.0
        OponenteDos.layer.cornerRadius = 2.0
        // Initialization code
    }
    
    func setBattle(_ battle: Battle) {
        self.battle = battle
        self.battleID.text = "Batalla: \(self.battle?.id ?? 0)"
        
        oponenteUno.image = UIImage.init(named: self.battle?.adversaryOne?.imagen ?? "")
        OponenteDos.image = UIImage.init(named: self.battle?.adversaryTwo?.imagen ?? "")
        if battle.winner == self.battle?.adversaryOne?.nombre {
            oponenteUno.layer.borderWidth = 3.0
            oponenteUno.layer.borderColor = UIColor.red.cgColor
            OponenteDos.layer.borderWidth = 3.0
            OponenteDos.layer.borderColor = UIColor.blue.cgColor
        } else {
            oponenteUno.layer.borderWidth = 3.0
            oponenteUno.layer.borderColor = UIColor.blue.cgColor
            OponenteDos.layer.borderWidth = 3.0
            OponenteDos.layer.borderColor = UIColor.red.cgColor
        }
    }
    
}
