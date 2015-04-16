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
        if segue.identifier == Constants.Segue.DOG {
            if let destinationVC = segue.destinationViewController as? ProjectDisplayViewController {
                destinationVC.projectName = Constants.Project.DOG
            }
        } else if segue.identifier == Constants.Segue.CAT {
            if let destinationVC = segue.destinationViewController as? ProjectDisplayViewController {
                destinationVC.projectName = Constants.Project.CAT
            }
        } else if segue.identifier == Constants.Segue.GUINEAPIG {
            if let destinationVC = segue.destinationViewController as? ProjectDisplayViewController {
                destinationVC.projectName = Constants.Project.GUINEAPIG
            }
        } else if segue.identifier == Constants.Segue.RABBIT {
            if let destinationVC = segue.destinationViewController as? ProjectDisplayViewController {
                destinationVC.projectName = Constants.Project.RABBIT
            }
        }
    }

    
    
}