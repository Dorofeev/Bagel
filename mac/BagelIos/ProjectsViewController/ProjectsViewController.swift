//
//  ProjectsViewController.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 22.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {
    
    var viewModel: ProjectsViewModel?
    var onProjectSelect : ((BagelProjectController) -> ())?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        print(BagelController.shared)
    }
    
    func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = LightTheme().projectListBackgroundColor
        
        self.viewModel?.onChange = { [weak self] in
            print("self.refresh")
            self?.refresh()
        }
        
        tableView.register(
            UINib(
                nibName: "ProjectTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "ProjectTableViewCell"
        )
    }
    
    func refresh() {
        self.tableView.reloadData()
    }
}

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath)
            as? ProjectTableViewCell
            ?? ProjectTableViewCell()
        
        cell.project = self.viewModel?.item(at: indexPath.row)
        
        cell.refresh()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = self.viewModel?.item(at: indexPath.row) {
            
            self.onProjectSelect?(item)
        }
    }
}
