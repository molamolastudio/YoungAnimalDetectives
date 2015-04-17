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
    @IBOutlet weak var projectEthogramImage: UIView!
    
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    
    @IBOutlet weak var individualNickname: UITextView!
    @IBOutlet weak var individualType: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        }
        animalProfileImage.reloadInputViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}