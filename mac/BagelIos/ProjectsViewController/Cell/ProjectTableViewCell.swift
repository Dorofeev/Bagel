//
//  ProjectTableViewCell.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 23.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var project: BagelProjectController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func refresh() {
        let theme = LightTheme()
        
        self.titleLabel.text = self.project.projectName ?? ""
        backView.layer.cornerRadius = 10
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.titleLabel.textColor = theme.projectTextColor
    }
    
}
