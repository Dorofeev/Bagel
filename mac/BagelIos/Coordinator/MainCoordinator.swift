//
//  MainCoordinator.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 29.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import UIKit

class MainCoordinator {
    
    private var navigationController: UINavigationController?
    
    func start(windowScene: UIWindowScene) -> UIWindow {
        let projectsController = ProjectsViewController()
        navigationController = UINavigationController(rootViewController: projectsController)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        let viewModel = ProjectsViewModel()
        viewModel.register()
        
        projectsController.viewModel = viewModel
        
        projectsController.onProjectSelect = { [weak self] (selectedProjectController) in
            BagelController.shared.selectedProjectController = selectedProjectController
            self?.routeToDevices()
        }
        return window
    }
    
    private func routeToDevices() {
        let devicesViewController = DevicesViewController()
        devicesViewController.viewModel = DevicesViewModel()
        devicesViewController.viewModel?.register()
        
        devicesViewController.onDeviceSelect = { [weak self] (selectedDeviceController) in
            
            BagelController.shared.selectedProjectController?.selectedDeviceController = selectedDeviceController
            self?.routeToPackets()
        }
        navigationController?.pushViewController(devicesViewController, animated: true)
    }
    
    private func routeToPackets() {
        let packetsViewController = PacketsViewController()
        let viewModel = PacketsViewModel()
        packetsViewController.viewModel = viewModel
        viewModel.register()
        packetsViewController.onPacketSelect = { (selectedPacket) in
            BagelController.shared.selectedProjectController?.selectedDeviceController?.select(packet: selectedPacket)
        }
        navigationController?.pushViewController(packetsViewController, animated: true)
    }
}
