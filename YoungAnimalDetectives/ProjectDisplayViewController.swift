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
    @IBOutlet weak var projectTitle: UITextView!

    
    @IBOutlet weak var nicknameField: UITextField!
    @IBAction func didTypeNickname(sender: AnyObject) {
        SharedData.sharedInstance.nickname = nicknameField.text
        StorageManager.saveProjectToArchives()
        nicknameField.resignFirstResponder()
    }
    @IBOutlet weak var typeField: UITextField!
    @IBAction func didTypeType(sender: AnyObject) {
        SharedData.sharedInstance.type = typeField.text
        StorageManager.saveProjectToArchives()
        typeField.resignFirstResponder()
    }
    
    @IBOutlet weak var individualNickname: UITextView!
    @IBOutlet weak var individualType: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(SharedData.sharedInstance.currentProject)
        
        let FONT_SIZE_INPUT = CGFloat(40)
        let FONT_SIZE_TITLE = CGFloat(35)
        let FONT_WHITE_COLOR = CGFloat(1.0)
        let FONT_WHITE_ALPHA = CGFloat(1.0)
        
        if let project = SharedData.sharedInstance.currentProject {
            switch (project) {
            case Constants.Project.DOG:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_DOG)
                projectTitle.text = Constants.Project.TITLE_DOG
            case Constants.Project.CAT:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_CAT)
                projectTitle.text = Constants.Project.TITLE_CAT
            case Constants.Project.GUINEAPIG:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_GUINEAPIG)
                projectTitle.text = Constants.Project.TITLE_GUINEAPIG
            case Constants.Project.RABBIT:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_RABBIT)
                projectTitle.text = Constants.Project.TITLE_RABBIT
            default:
                break
            }
        }
        
        projectTitle.font = UIFont(descriptor: UIFontDescriptor(name: Constants.Font.CHALKDUSTER, size: 0), size: FONT_SIZE_TITLE)
        projectTitle.textColor = UIColor(white: FONT_WHITE_COLOR, alpha: FONT_WHITE_ALPHA)

        if let name = SharedData.sharedInstance.nickname {
            nicknameField.hidden = true
            individualNickname.text = name
            individualNickname.font = UIFont(descriptor: UIFontDescriptor(name: Constants.Font.CHALKDUSTER, size: 0), size: FONT_SIZE_INPUT)
            individualNickname.textColor = UIColor(white: FONT_WHITE_COLOR, alpha: FONT_WHITE_ALPHA)
        } else {
            individualNickname.hidden = true
        }
        
        if let type = SharedData.sharedInstance.type {
            typeField.hidden = true
            individualType.text = type
            individualType.font = UIFont(descriptor: UIFontDescriptor(name: Constants.Font.CHALKDUSTER, size: 0), size: FONT_SIZE_INPUT)
            individualType.textColor = UIColor(white: FONT_WHITE_COLOR, alpha: FONT_WHITE_ALPHA)
        } else {
            individualType.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}