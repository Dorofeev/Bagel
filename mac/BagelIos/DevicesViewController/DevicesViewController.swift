//
//  DevicesViewController.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 24.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import UIKit

class DevicesViewController: UIViewController {
    
    var viewModel: DevicesViewModel?
    var onDeviceSelect : ((BagelDeviceController) -> ())?
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        refresh()
    }
    
    private func setup() {
        
        navigationItem.title = "Devices"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = LightTheme().deviceListBackgroundColor
        
        self.viewModel?.onChange = { [weak self] in
            
            self?.refresh()
        }
        
        tableView.register(
            UINib(
                nibName: "DeviceTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "DeviceTableViewCell"
        )
    }
    
    private func refresh() {
        self.tableView.reloadData()
    }
}

extension DevicesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.itemCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath)
            as? DeviceTableViewCell
            ?? DeviceTableViewCell()
        
        cell.device = self.viewModel?.item(at: indexPath.row)
        
        cell.refresh()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = self.viewModel?.item(at: indexPath.row) {
            
            self.onDeviceSelect?(item)
        }
    }
}
