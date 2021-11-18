//
//  DeviceTableViewCell.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 24.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceDescriptionLabel: UILabel!
    
    var device: BagelDeviceController!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backView.backgroundColor = LightTheme().deviceRowSelectedColor
        backView.layer.cornerRadius = 10
    }
    
    func refresh() {
        
        self.deviceNameLabel.text = self.device.deviceName ?? ""
        self.deviceDescriptionLabel.text = self.device.deviceDescription ?? ""
        
        self.deviceNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.deviceNameLabel.textColor = LightTheme().contentTextColor
    }
    
}
