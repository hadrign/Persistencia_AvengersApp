//
//  HerosBattleViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 03/05/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

protocol HerosBattleViewControllerDelegate {
    func didHeroSelected(withHero hero: Hero)
}


class HerosBattleViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var heros: [Hero] = []
    private var dataProvider = DataProvider()
    var delegate: HerosBattleViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData()
    }
    
    // MARK: Setup
    func setupUI() {
        self.title = "SuperHeroes"
        
        let nib = UINib.init(nibName: "HerosBattleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HerosBattleTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupData() {
        loadAllHeros()
    }

    
    // MARK: Private methods
    func loadAllHeros() {
        heros = dataProvider.loadAllHeros()
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return screenSize.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = heros[indexPath.row]
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didHeroSelected(withHero: hero)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     // MARK: - UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HerosBattleTableViewCell", for: indexPath) as? HerosBattleTableViewCell {
            let hero = heros[indexPath.row]
            cell.setHero(hero)
            return cell
        }
        fatalError("Could not create the Cast cell")
    }

}
