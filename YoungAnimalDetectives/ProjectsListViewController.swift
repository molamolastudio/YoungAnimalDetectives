//
//  ProjectsListViewController.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 15/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import UIKit

class ProjectsListViewController: UIViewController {
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        SharedData.sharedInstance.nickname = nil
        SharedData.sharedInstance.type = nil
        SharedData.sharedInstance.project = nil
        
        if segue.identifier == Constants.Segue.DOG {
            SharedData.sharedInstance.currentProject = Constants.Project.TITLE_DOG
            StorageManager.loadProjectFromArchives()
        } else if segue.identifier == Constants.Segue.CAT {
            SharedData.sharedInstance.currentProject = Constants.Project.TITLE_CAT
            StorageManager.loadProjectFromArchives()
        } else if segue.identifier == Constants.Segue.GUINEAPIG {
            SharedData.sharedInstance.currentProject = Constants.Project.TITLE_GUINEAPIG
            StorageManager.loadProjectFromArchives()
        } else if segue.identifier == Constants.Segue.RABBIT {
            SharedData.sharedInstance.currentProject = Constants.Project.TITLE_RABBIT
            StorageManager.loadProjectFromArchives()
        }
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as! UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager

    }

}