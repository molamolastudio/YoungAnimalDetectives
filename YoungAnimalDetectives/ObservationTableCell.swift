//
//  ObservationTableCell.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 18/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import Foundation
import UIKit

public class ObservationTableCell : UITableViewCell {
    static let id: String = "ObservationTableCell"
    
    var timeLabel: UILabel
    var behaviourLabel: UILabel
    var infoLabel: UILabel
    
    init() {
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        behaviourLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 50))
        infoLabel = UILabel(frame: CGRect(x: 200, y: 0, width: 150, height: 50))
        
        timeLabel.backgroundColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 0.5)
        behaviourLabel.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 0.5)
        infoLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.5)
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: ObservationTableCell.id)
        
        addSubview(timeLabel)
        addSubview(behaviourLabel)
        addSubview(infoLabel)
    }

    required public init(coder aDecoder: NSCoder) {
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        behaviourLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 50))
        infoLabel = UILabel(frame: CGRect(x: 200, y: 0, width: 150, height: 50))
        
        timeLabel.backgroundColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 0.5)
        behaviourLabel.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 0.5)
        infoLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.5)
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: ObservationTableCell.id)
        
        addSubview(timeLabel)
        addSubview(behaviourLabel)
        addSubview(infoLabel)
        
    }
}