//
//  EditPowerVillainViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 02/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

protocol EditPowerVillainControllerDelegate {
    func didPowerVillainChange()
}

class EditPowerVillainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var powerBtn: UIButton!
    
    private var villain: Villain?
    var delegate: EditPowerVillainControllerDelegate?
    private var dataProvider = DataProvider()
    
    convenience init(withVillain villain: Villain) {
        self.init()
        self.villain = villain
        self.title = villain.nombre
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage.init(named: self.villain?.imagen ?? "")
        self.powerBtn.setImage(UIImage.init(named: "ic_stars_\(self.villain?.poder ?? 0)"), for: .normal)
    }


    //MARK: IBActions
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func editingPower(_ sender: Any) {
        if self.villain?.poder == 5 {
            self.villain?.poder = 0
            self.powerBtn.setImage(UIImage.init(named: "ic_stars_\(self.villain?.poder ?? 0)"), for: .normal)
        } else {
            self.villain?.poder+=1
            self.powerBtn.setImage(UIImage.init(named: "ic_stars_\(self.villain?.poder ?? 0)"), for: .normal)
        }
    }
    
    
    @IBAction func acceptAction(_ sender: Any) {
        let villainData = dataProvider.loadVillain(name: self.villain?.nombre ?? "")
        villainData.first?.poder = Int16(self.villain?.poder ?? 0)
        guard let villain = villainData.first else {
            return
        }
        dataProvider.saveVillain(villain)
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.delegate?.didPowerVillainChange()
        let noteName = Notification.Name(rawValue: "DidPowerVillainUpdated")
        NotificationCenter.default.post(name: noteName, object: nil)
    }

}
