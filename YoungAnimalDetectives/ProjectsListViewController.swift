//
//  ProjectsListViewController.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 15/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import UIKit

class ProjectsListViewController: UIViewController {
    
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
            SharedData.sharedInstance.currentProject = Constants.Project.DOG
            StorageManager.loadProjectFromArchives()
        } else if segue.identifier == Constants.Segue.CAT {
            SharedData.sharedInstance.currentProject = Constants.Project.CAT
            StorageManager.loadProjectFromArchives()
        } else if segue.identifier == Constants.Segue.GUINEAPIG {
            SharedData.sharedInstance.currentProject = Constants.Project.GUINEAPIG
            StorageManager.loadProjectFromArchives()
        } else if segue.identifier == Constants.Segue.RABBIT {
            SharedData.sharedInstance.currentProject = Constants.Project.RABBIT
            StorageManager.loadProjectFromArchives()
        }
        
        println(SharedData.sharedInstance.nickname)
        println(SharedData.sharedInstance.type)
    }
}