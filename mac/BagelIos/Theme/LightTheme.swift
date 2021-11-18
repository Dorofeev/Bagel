//
//  LightTheme.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 23.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import Foundation
import UIKit

class LightTheme {
    var contentTextColor: UIColor {
        return UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0)
    }
    
    @objc var controlBackgroundColor: UIColor {
        return UIColor.white
    }
    
    @objc var labelColor: UIColor {
        return UIColor.darkGray
    }
    
    @objc var secondaryLabelColor: UIColor {
        return UIColor.lightGray
    }
    
    @objc var contentBarColor: UIColor {
        return UIColor(hexString: "#f4f4f4")
    }
    
    @objc var gridColor: UIColor {
        return UIColor(hexString: "#F0F0F0")
    }
    
    @objc var seperatorColor: UIColor {
        return UIColor(hexString: "#F0F0F0")
    }
    
    @objc var rowSelectedColor: UIColor {
        return UIColor(hexString: "#F0F0F0")
    }
    
    @objc var statusGreenColor: UIColor {
        return UIColor(hexString: "#2ECC71")
    }
    
    @objc var statusOrangeColor: UIColor {
        return UIColor(hexString: "#F1C40F")
    }
    
    @objc var statusRedColor: UIColor {
        return UIColor(hexString: "#E74C3C")
    }
    
    @objc var projectListBackgroundColor: UIColor {
        return UIColor(hexString: "#232323")
    }
    
    @objc var projectTextColor: UIColor {
        return UIColor(hexString: "#ffffff")
    }
    
    @objc var deviceListBackgroundColor: UIColor {
        return UIColor(hexString: "#F6F6F6")
    }
    
    @objc var deviceRowSelectedColor: UIColor {
        return UIColor(hexString: "#ffffff")
    }
    
    @objc var packetListAndDetailBackgroundColor: UIColor {
        return UIColor(hexString: "#F0F0F0")
    }
}

extension LightTheme {
    
    
    @objc var clearIcon: UIImage {
        return UIImage(named: "TrashIcon")!
    }
    
    @objc var copyToClipboardIcon: UIImage {
        return UIImage(named: "CopyIcon")!
    }
}


extension LightTheme {
    
    @objc var httpMethodGetColor: UIColor {
        return UIColor(hexString: "#00cec9")
    }
    
    @objc var httpMethodPostColor: UIColor {
        return UIColor(hexString: "#fdcb6e")
    }
    
    @objc var httpMethodDeleteColor: UIColor {
        return UIColor(hexString: "#e17055")
    }
    
    @objc var httpMethodPutColor: UIColor {
        return UIColor(hexString: "#0984e3")
    }
    
    @objc var httpMethodDefaultColor: UIColor {
        return self.secondaryLabelColor
    }
}
