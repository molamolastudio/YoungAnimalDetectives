//
//  ProjectDisplayViewController.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 15/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import UIKit

class ProjectDisplayViewController: UIViewController {
    let transitionManager = TransitionManager()
    
    @IBOutlet weak var animalProfileImage: UIImageView!
    @IBOutlet weak var projectTitle: UITextView!

    @IBAction func goToObservations(sender: AnyObject) {
        // check whether nickname and type is filled in
        if SharedData.sharedInstance.nickname == nil
                && SharedData.sharedInstance.type == nil
                && (nicknameField.text == "" || typeField.text == "") {
                    
            let title = "Missing information"
            let msg = "Please key in nickname and type"
            let action = "OK"
                    
            let actionSheetController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
            let OKAction = UIAlertAction(title: action, style: .Default) { (action) in }
            actionSheetController.addAction(OKAction)
        
            //We need to provide a popover sourceView when using it on iPad
            actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
            //Present the AlertController
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        } else {
            SharedData.sharedInstance.nickname = nicknameField.text
            SharedData.sharedInstance.type = typeField.text
            
            SharedData.sharedInstance.individual = Individual(label:
                SharedData.sharedInstance.nickname!)
            
            // Add individual to the project
            if SharedData.sharedInstance.project!.individuals.isEmpty {
                SharedData.sharedInstance.project!.addIndividuals([SharedData.sharedInstance.individual!])
            } else {
                SharedData.sharedInstance.project!.updateIndividual(0, updatedIndividual: SharedData.sharedInstance.individual!)
            }
            
            StorageManager.saveProjectToArchives()
            StorageManager.loadProjectFromArchives()
            performSegueWithIdentifier(Constants.Segue.GO_OBSERVATIONS, sender: self)
        }
    }
    
    @IBOutlet weak var nicknameField: UITextField!
    @IBAction func didTypeNickname(sender: AnyObject) {
        nicknameField.resignFirstResponder()
    }
    @IBOutlet weak var typeField: UITextField!
    @IBAction func didTypeType(sender: AnyObject) {
        typeField.resignFirstResponder()
    }
    
    @IBOutlet weak var individualNickname: UITextView!
    @IBOutlet weak var individualType: UITextView!
    
    @IBAction func resetProject(sender: AnyObject) {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: Constants.Words.OBS_FORM_RESET_TITLE, message: Constants.Words.OBS_FORM_RESET_WARNING, preferredStyle: .ActionSheet)
        
        let destroyAction = UIAlertAction(title: Constants.Words.PROJ_ALERT_DESTROY, style: .Destructive) { (action) in
            SharedData.sharedInstance.nickname = nil
            SharedData.sharedInstance.type = nil
            
            let ethogram: Ethogram = StandardEthogram.getEthogram()
            SharedData.sharedInstance.project = Project(name: SharedData.sharedInstance.currentProject!, ethogram: ethogram)
            let session = Session(project: SharedData.sharedInstance.project!, name: Constants.Words.SESSION_UNLIMITED, type: SessionType.Focal)
            SharedData.sharedInstance.project!.addSessions([session])
            
            StorageManager.saveProjectToArchives()
            
            self.nicknameField.hidden = false
            self.individualNickname.hidden = true
            self.nicknameField.text = Constants.Words.EMPTY_STRING
            
            self.typeField.hidden = false
            self.individualType.hidden = true
            self.typeField.text = Constants.Words.EMPTY_STRING
        }
        let cancelAction = UIAlertAction(title: Constants.Words.OBS_FORM_CANCEL, style: .Cancel) { (_) in }
        
        actionSheetController.addAction(destroyAction)
        actionSheetController.addAction(cancelAction)
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let FONT_SIZE_INPUT = CGFloat(40)
        let FONT_SIZE_TITLE = CGFloat(35)
        let FONT_WHITE_COLOR = CGFloat(1.0)
        let FONT_WHITE_ALPHA = CGFloat(1.0)
        
        if let project = SharedData.sharedInstance.currentProject {
            switch (project) {
            case Constants.Project.TITLE_DOG:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_DOG)
                projectTitle.text = Constants.Project.TITLE_DOG
            case Constants.Project.TITLE_CAT:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_CAT)
                projectTitle.text = Constants.Project.TITLE_CAT
            case Constants.Project.TITLE_GUINEAPIG:
                animalProfileImage.image = UIImage(named: Constants.Image.SQUARE_GUINEAPIG)
                projectTitle.text = Constants.Project.TITLE_GUINEAPIG
            case Constants.Project.TITLE_RABBIT:
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let FONT_SIZE_INPUT = CGFloat(40)
        let FONT_SIZE_TITLE = CGFloat(35)
        let FONT_WHITE_COLOR = CGFloat(1.0)
        let FONT_WHITE_ALPHA = CGFloat(1.0)
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Implement custom transition
        let toViewController = segue.destinationViewController as! UIViewController
        toViewController.transitioningDelegate = self.transitionManager
        
    }
}