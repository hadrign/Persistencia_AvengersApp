//
//  BattlesViewController.swift
//  AvengersApp
//
//  Created by Hadrian Grille Negreira on 27/04/2020.
//  Copyright © 2020 Hadrian Grille Negreira. All rights reserved.
//

import UIKit

class BattlesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBattle: UIButton!
    
    var battles: [Battle] = []
    private var dataProvider = DataProvider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupNotification()
        self.setupData()
    }
    
    
    //MARK: Setup
    
    func setupUI() {
        self.title = "Batallas"
        
        let nib = UINib.init(nibName: "BattleTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BattleTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        addBattle.layer.cornerRadius = 30.0
        addBattle.layer.borderWidth = 1.0
        addBattle.layer.borderColor = UIColor.blue.withAlphaComponent(0.6).cgColor
    }
    
    func setupNotification() {
        let noteName = Notification.Name(rawValue: "DidBattleUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBattleUpdated), name: noteName, object: nil)
    }
    
    func setupData() {
        loadAllBattles()
    }
    
    //MARK: Notifications
    @objc func didBattleUpdated() {
        battles = dataProvider.loadAllBattles()
        self.tableView.reloadData()
    }
    
    //MARK: Private methods
    
    func loadAllBattles() {
        battles = dataProvider.loadAllBattles()
        print("*-*-*-*-*-*-*-*-*-*-* \(battles)")
    }
    
    //MARK: IBActions
    @IBAction func launchBattle(_ sender: Any) {
        let addBattleVC = AddBattleViewController()
        self.navigationController?.pushViewController(addBattleVC, animated: true)
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return screenSize.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     // MARK: - UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return battles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BattleTableViewCell", for: indexPath) as? BattleTableViewCell {
            let battle = battles[indexPath.row]
            cell.setBattle(battle)
            return cell
        }
        fatalError("Could not create the Cast cell")
    }
    


}
