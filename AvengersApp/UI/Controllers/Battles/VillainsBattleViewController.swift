//
//  VillainsBattleViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 03/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

protocol VillainsBattleViewControllerDelegate {
    func didVillainSelected(withVillain villano: Villain)
}

class VillainsBattleViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var villanos: [Villain] = []
    private var dataProvider = DataProvider()
    var delegate: VillainsBattleViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData()
    }
    
    // MARK: Setup
    func setupUI() {
        self.title = "Villanos"
        
        let nib = UINib.init(nibName: "VillainsBattleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "VillainsBattleTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupData() {
        loadAllHeros()
    }

    
    // MARK: Private methods
    func loadAllHeros() {
        villanos = dataProvider.loadAllVillains()
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return screenSize.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let villain = villanos[indexPath.row]
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didVillainSelected(withVillain: villain)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     // MARK: - UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return villanos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VillainsBattleTableViewCell", for: indexPath) as? VillainsBattleTableViewCell {
            let villano = villanos[indexPath.row]
            cell.setVillano(villano)
            return cell
        }
        fatalError("Could not create the Cast cell")
    }


}
