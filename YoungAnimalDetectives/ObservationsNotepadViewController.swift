//
//  ObservationsNotepadViewController.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 15/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import UIKit

class ObservationsNotepadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    var addBSNum: Int?
    
    @IBOutlet weak var observationTable: UITableView!
    @IBAction func addObservation(sender: AnyObject) {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: Constants.Words.OBS_FORM_ADD_TITLE, message: Constants.Words.EMPTY_STRING, preferredStyle: .ActionSheet)
        
        let movingAction = UIAlertAction(title: StandardEthogram.getEthogram().behaviourStates[0].name, style: .Default) { (_) in
            self.addBSNum = 0
            self.createInformationPopUp(self)
        }
        let groomingAction = UIAlertAction(title: StandardEthogram.getEthogram().behaviourStates[1].name, style: .Default) { (_) in
            self.addBSNum = 1
            self.createInformationPopUp(self)
        }
        let ingestingAction = UIAlertAction(title: StandardEthogram.getEthogram().behaviourStates[2].name, style: .Default) { (_) in
            self.addBSNum = 2
            self.createInformationPopUp(self)
        }
        let restingAction = UIAlertAction(title: StandardEthogram.getEthogram().behaviourStates[3].name, style: .Default) { (_) in
            self.addBSNum = 3
            self.createInformationPopUp(self)
        }
        let notVisibleAction = UIAlertAction(title: StandardEthogram.getEthogram().behaviourStates[4].name, style: .Default) { (_) in
            self.addBSNum = 4
            self.createInformationPopUp(self)
        }
        
        actionSheetController.addAction(movingAction)
        actionSheetController.addAction(groomingAction)
        actionSheetController.addAction(ingestingAction)
        actionSheetController.addAction(restingAction)
        actionSheetController.addAction(notVisibleAction)

        let cancelAction = UIAlertAction(title: Constants.Words.OBS_FORM_CANCEL, style: .Cancel) { (_) in }
        
        actionSheetController.addAction(cancelAction)
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func createInformationPopUp(sender: AnyObject) {
        let actionSheetController: UIAlertController = UIAlertController(title: Constants.Words.OBS_FORM_TITLE, message: "", preferredStyle: .Alert)
        
        let infoAction = UIAlertAction(title: Constants.Words.OBS_FORM_DONE, style: .Default) { (_) in
            let infoField = actionSheetController.textFields![0] as! UITextField
            if let nick = SharedData.sharedInstance.nickname {
                let individual = Individual(label: nick)
                
                if let project = SharedData.sharedInstance.project {
                    
                    var session = Session(project: SharedData.sharedInstance.project!, name: Constants.Words.SESSION_UNLIMITED, type: SessionType.Focal)
                    
                    if project.sessions.count == 0 {
                        project.addSessions([session])
                    } else {
                        session = SharedData.sharedInstance.project!.sessions[0]
                    }
                    
                    let individual = Individual(label: SharedData.sharedInstance.nickname!)
                    let ethogram: Ethogram = StandardEthogram.getEthogram()
                    var observation = Observation(session: session, individual: individual, state: ethogram.behaviourStates[self.addBSNum!], timestamp: NSDate(), information: infoField.text)
                    session.addObservation([observation])
                    
                    StorageManager.saveProjectToArchives()
                    self.observationTable.reloadData()
                }
            }
        }
        
        infoAction.enabled = false
        
        actionSheetController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = Constants.Words.PLACEHOLDER_INFO
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                infoAction.enabled = textField.text != ""
            }
        }
        let cancelAction = UIAlertAction(title: Constants.Words.OBS_FORM_CANCEL, style: .Cancel) { (_) in }
        actionSheetController.addAction(infoAction)
        actionSheetController.addAction(cancelAction)
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var addObservationBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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
        let obsCell = Constants.Table.OBSERVATION_CELL_ID
        
        let cell = observationTable.dequeueReusableCellWithIdentifier(obsCell, forIndexPath: indexPath) as! UITableViewCell
        let observation = SharedData.sharedInstance.project!.sessions[0].observations[indexPath.row]
        
        let dateLabel = cell.viewWithTag(11) as! UILabel
        let timeLabel = cell.viewWithTag(14) as! UILabel
        let behaviourLabel = cell.viewWithTag(12) as! UILabel
        let infoLabel = cell.viewWithTag(13) as! UILabel
        
        dateLabel.text = observation.timestamp.toDisplayDateFormat()
        timeLabel.text = observation.timestamp.toDisplayTimeFormat()
        behaviourLabel.text = observation.state.name
        infoLabel.text = observation.information
        
        return cell
    }
    
    // This function sets the height of the observation row
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let rowHeight = CGFloat(86)
        return rowHeight
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
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