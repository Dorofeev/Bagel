//
//  PacketTableViewCell.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 25.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import UIKit

class PacketTableViewCell: UITableViewCell {
    
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var methodLabel: UILabel!
    @IBOutlet private var urlLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    var packet: BagelPacket!
    {
        didSet
        {
            self.refresh()
        }
    }
    
    private func refresh() {
        setupStatus()
        setupMethod()
        setupUrl()
        setupDate()
    }
    
    private func setupStatus() {
        var titleTextColor = UIColor.black
        
        if let statusCodeInt = self.packet.requestInfo?.statusCode {
            
            if let statusCodeInt = Int(statusCodeInt) {
                
                if statusCodeInt >= 200 && statusCodeInt < 300 {
                    
                    titleTextColor = LightTheme().statusGreenColor
                    
                } else if statusCodeInt >= 300 && statusCodeInt < 400 {
                    
                    titleTextColor = LightTheme().statusOrangeColor
                    
                } else if statusCodeInt >= 400 {
                    
                    titleTextColor = LightTheme().statusRedColor
                }
                
            }
        }
        
        self.statusLabel.textColor = titleTextColor
        self.statusLabel.text = self.packet.requestInfo?.statusCode ?? ""
    }
    
    private func setupMethod() {
        var methodColor = LightTheme().httpMethodDefaultColor
        
        if let requestMethod = packet.requestInfo?.requestMethod {
            switch requestMethod {
                case .get:
                    methodColor = LightTheme().httpMethodGetColor
                case .put:
                    methodColor = LightTheme().httpMethodPutColor
                case .post:
                    methodColor = LightTheme().httpMethodPostColor
                case .delete:
                    methodColor = LightTheme().httpMethodDeleteColor
                case .patch:
                    methodColor = LightTheme().httpMethodDefaultColor
                case .head:
                    break
            }
        }
        
        self.methodLabel.textColor = methodColor
        self.methodLabel.text = packet.requestInfo?.requestMethod?.rawValue ?? ""
    }
    
    private func setupUrl() {
        urlLabel.textColor = LightTheme().labelColor
        urlLabel.text = packet.requestInfo?.url ?? ""
    }
    
    private func setupDate() {
        dateLabel.textColor = LightTheme().secondaryLabelColor
        dateLabel.text = packet.requestInfo?.startDate?.readable ?? ""
    }
}
