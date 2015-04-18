//
//  ObservationsNotepadViewController.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 15/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import UIKit

class ObservationsNotepadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var observationTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let nick = SharedData.sharedInstance.nickname {
            let individual = Individual(label: nick)
            
            if let project = SharedData.sharedInstance.project {
                
                var session: Session
                if project.sessions.count == 0 {
                    session = Session(project: SharedData.sharedInstance.project!, name: "Unlimited Session", type: SessionType.Focal)
                    project.addSessions([session])
                } else {
                    session = SharedData.sharedInstance.project!.sessions[0]
                }
                
                let ethogram: Ethogram = StandardEthogram.getEthogram()
                var observation = Observation(session: session, individual: individual, state: ethogram.behaviourStates[0], timestamp: NSDate(), information: "")
                session.addObservation([observation])
                
                StorageManager.saveProjectToArchives()
            }
        }
        
        
        observationTable.delegate = self
        observationTable.dataSource = self
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function sets the number of sections in the table view.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // This function sets the number of rows in table view.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let project = SharedData.sharedInstance.project {
            return project.sessions[0].observations.count
        }
        return 0
    }
    
    // This function sets the observation.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let obsCell = ObservationTableCell.id
        
        let cell = observationTable.dequeueReusableCellWithIdentifier(obsCell, forIndexPath: indexPath) as! ObservationTableCell
        let observation = SharedData.sharedInstance.project!.sessions[0].observations[indexPath.row]
        
        cell.timeLabel.text = observation.timestamp.toBiolifeDateFormat()
        cell.behaviourLabel.text = observation.state.name
        cell.infoLabel.text = observation.information
        
        println("Accessed")
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // This function deletes a game file
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let project = SharedData.sharedInstance.project {
                project.sessions[0].removeObservations([indexPath.row])
            }
        }
    }
    
    // This function sets the action after selecting a game file.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}