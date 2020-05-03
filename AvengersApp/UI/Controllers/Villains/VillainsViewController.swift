//
//  VillainsViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 27/04/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class VillainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var villanos: [Villain] = []
    private var dataProvider = DataProvider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupNotification()
        self.setupData()
        
        

        // Do any additional setup after loading the view.
    }
    
    // MARK: Setup
    func setupUI() {
        self.title = "Villanos"
        
        let nib = UINib.init(nibName: "VillanoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "VillanoTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupNotification() {
        let noteName = Notification.Name(rawValue: "DidPowerVillainUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPowerVillainChange), name: noteName, object: nil)
    }
    
    func setupData() {
        loadAllVillains()
    }
    
    //MARK: Notifications
    @objc func didPowerVillainChange() {
        self.tableView.reloadData()
    }
    
    // MARK: Private methods
    func loadAllVillains() {
        villanos = dataProvider.loadAllVillains()
        if villanos.count == 0 {
            getAllVillains()
            villanos = dataProvider.loadAllVillains()
        }
        
    }
    
    func getAllVillains() {
        let villanosJson: [VillainsData]
        if let pathURL = Bundle.main.url(forResource: "VillainsComplete", withExtension: "json"){
            do{
                print(pathURL)
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                villanosJson = try decoder.decode([VillainsData].self, from: data)
            } catch{
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
        villanosJson.forEach{ dataVillain in
            guard let villano = dataProvider.createVillain() else {
                return
            }
            villano.imagen = dataVillain.imagen
            villano.nombre = dataVillain.nombre
            villano.descripcion = dataVillain.descripcion
            villano.poder = Int16(dataVillain.poder)
            dataProvider.saveVillain(villano)
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return screenSize.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let villain = villanos[indexPath.row]
        let villainDetailVC = DetailVillainViewController.init(withVillain: villain)
        self.navigationController?.pushViewController(villainDetailVC, animated: true)
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VillanoTableViewCell", for: indexPath) as? VillanoTableViewCell {
            let villano = villanos[indexPath.row]
            cell.setVillano(villano)
            //cell.delete = self
            return cell
        }
        fatalError("Could not create the Cast cell")
    }


}
