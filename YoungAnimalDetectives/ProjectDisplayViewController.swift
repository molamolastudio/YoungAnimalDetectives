//
//  ProjectDisplayViewController.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 15/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import UIKit

class ProjectDisplayViewController: UIViewController {
    
    @IBOutlet weak var animalProfileImage: UIImageView!

    
    @IBOutlet weak var nicknameField: UITextField!
    @IBAction func didTypeNickname(sender: AnyObject) {
        SharedData.sharedInstance.nickname = nicknameField.text
        StorageManager.saveProjectToArchives()
    }
    @IBOutlet weak var typeField: UITextField!
    @IBAction func didTypeType(sender: AnyObject) {
        SharedData.sharedInstance.nickname = typeField.text
        StorageManager.saveProjectToArchives()
    }
    
    @IBOutlet weak var individualNickname: UITextView!
    @IBOutlet weak var individualType: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let FONT_SIZE = CGFloat(40)
        let FONT_WHITE_COLOR = CGFloat(1.0)
        let FONT_WHITE_ALPHA = CGFloat(1.0)
        
        if let project = SharedData.sharedInstance.currentProject {
            switch (project) {
            case Constants.Project.DOG:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_DOG)
            case Constants.Project.CAT:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_CAT)
            case Constants.Project.GUINEAPIG:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_GUINEAPIG)
            case Constants.Project.RABBIT:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_RABBIT)
            default:
                break
            }
            StorageManager.loadProjectFromArchives()
        }
        
        if let name = SharedData.sharedInstance.nickname {
            nicknameField.hidden = true
            individualNickname.text = name
            individualNickname.font = UIFont(descriptor: UIFontDescriptor(name: Constants.Font.CHALKDUSTER, size: 0), size: FONT_SIZE)
            individualNickname.textColor = UIColor(white: FONT_WHITE_COLOR, alpha: FONT_WHITE_ALPHA)
        }
        
        if let type = SharedData.sharedInstance.type {
            typeField.hidden = true
            individualType.text = type
            individualType.font = UIFont(descriptor: UIFontDescriptor(name: Constants.Font.CHALKDUSTER, size: 0), size: FONT_SIZE)
            individualType.textColor = UIColor(white: FONT_WHITE_COLOR, alpha: FONT_WHITE_ALPHA)
        }
        
        animalProfileImage.reloadInputViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}