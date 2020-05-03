//
//  HerosViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 27/04/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class HerosViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var heros: [Hero] = []
    private var dataProvider = DataProvider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupNotification()
        self.setupData()
    }
    
    // MARK: Setup
    func setupUI() {
        self.title = "SuperHeroes"
        
        let nib = UINib.init(nibName: "HeroTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HeroTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupNotification() {
        let noteName = Notification.Name(rawValue: "DidPowerHeroUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPowerHeroChange), name: noteName, object: nil)
    }
    
    func setupData() {
        loadAllHeros()
    }
    
    //MARK: Notifications
    @objc func didPowerHeroChange() {
        self.tableView.reloadData()
    }
    
    // MARK: Private methods
    func loadAllHeros() {
        heros = dataProvider.loadAllHeros()
        if heros.count == 0 {
            getAllHeros()
            heros = dataProvider.loadAllHeros()
        }
        
    }
    
    func getAllHeros() {
        let herosJson: [HerosData]
        if let pathURL = Bundle.main.url(forResource: "HerosComplete", withExtension: "json"){
            do{
                print(pathURL)
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                herosJson = try decoder.decode([HerosData].self, from: data)
            } catch{
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
        herosJson.forEach{ dataHero in
            guard let hero = dataProvider.createHero() else {
                return
            }
            hero.imagen = dataHero.imagen
            hero.nombre = dataHero.nombre
            hero.descripcion = dataHero.descripcion
            hero.poder = Int16(dataHero.poder)
            dataProvider.saveHero(hero)            
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return screenSize.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = heros[indexPath.row]
        let heroDetailVC = DetailHeroViewController.init(withHero: hero)
        self.navigationController?.pushViewController(heroDetailVC, animated: true)
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroTableViewCell", for: indexPath) as? HeroTableViewCell {
            let hero = heros[indexPath.row]
            cell.setHero(hero)
            //cell.delete = self
            return cell
        }
        fatalError("Could not create the Cast cell")
    }

}
