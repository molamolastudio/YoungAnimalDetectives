//
//  Session.swift
//  BioLifeTracker
//
//  Created by Michelle Tan on 10/3/15.
//  Maintained by Li Jia'En, Nicholette.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

enum SessionType: String {
    case Focal = "FCL"
    case Scan = "SCN"
}

//  This is a data model class for Session.
//  This class contains methods to initialise Session instances,
//  get and set instance attributes.
//  This class also contains methods to store and retrieve saved
//  Session instances to the disk.
class Session: Model, BLTSessionProtocol {
    // Constants
    static let projectKey = "project"
    static let nameKey = "name"
    static let intervalKey = "interval"
    static let observationsKey = "observations"
    static let individualsKey = "individuals"
    static let typeValueKey = "typeValue"
    static let sessionTypeKey = "session_type"
    static let observationSetKey = "observation_set"
    
    static let ClassUrl = "sessions"
    
    // Private attributes
    private var _name: String
    private var _project: Project!
    private var _typeValue: String
    private var _observations: [Observation]
    private var _individuals: [Individual]
    private var _interval: Int?
    
    // Accessors
    var type: SessionType { return SessionType(rawValue: _typeValue)! }
    var name: String { get { return _name } }
    var project: Project { get { return _project } }
    var observations: [Observation] { get { return _observations } }
    var individuals: [Individual] { get { return _individuals } }
    var interval: Int? { get { return _interval } }
    
    /// This function initialises an instance of a session
    init(project: Project, name: String, type: SessionType) {
        self._name = name
        self._project = project
        self._typeValue = type.rawValue
        self._observations = []
        self._individuals = []
        super.init()
    }
    
    /// This function returns the display name of a session
    func getDisplayName() -> String {
        return self._name
    }
    
    
    // MARK: METHODS FOR OBSERVATION
    
    
    /// This function sets the project owner of the session.
    /// To be called by Project instance during decoding
    func setProject(project: Project) {
        self._project = project
    }
    
    /// This function updates the name of the session.
    func updateName(name: String) {
        self._name = name
    }
    
    /// This function bulk adds observations to the session.
    func addObservation(observations: [Observation]) {
        self._observations += observations
        updateSession()
    }
    
    /// This function updates the observation at the specified index.
    func updateObservation(index: Int, updatedObservation: Observation) {
        self._observations.removeAtIndex(index)
        self._observations.insert(updatedObservation, atIndex: index)
        updateSession()
    }
    
    /// This function bulk removes observations at the specified indexes.
    func removeObservations(observationIndexes: [Int]) {
        // sort indexes in non-increasing order
        var decreasingIndexes = sorted(observationIndexes) { $0 > $1 }
        var prev = -1
        for (var i = 0; i < decreasingIndexes.count; i++) {
            let index = decreasingIndexes[i]
            if prev == index {
                continue;
            } else {
                prev = index
            }
            self._observations.removeAtIndex(index)
        }
        updateSession()
    }
    
    /// This function returns the timestamps in the session.
    func getTimestamps() -> [NSDate] {
        var timestamps: [NSDate] = []
        var duplicate: Bool
        
        for observation in observations {
            duplicate = false
            for timestamp in timestamps {
                if observation.timestamp == timestamp {
                    duplicate = true
                    break
                }
            }
            if !duplicate {
                timestamps.append(observation.timestamp)
            }
        }
        
        var sortedTimestamps = sorted(timestamps, {
            (left: NSDate, right: NSDate)
                    -> Bool in left.compare(right)
                            == NSComparisonResult.OrderedAscending })
        
        return sortedTimestamps
    }
    
    /// This function returns an array of observations that has the specified timestamp.
    func getObservationsByTimestamp(timestamp: NSDate) -> [Observation] {
        var selectedObs = [Observation]()
        
        for observation in observations {
            if observation.timestamp == timestamp {
                selectedObs.append(observation)
            }
        }
        return selectedObs
    }
    
    /// This is a private function used to sort dates.
    private func sortDates(date1: String, date2: String) -> Bool {
        return date1 > date2
    }
    
    /// This function returns all the observations that is related to a specified 
    /// individual
    func getAllObservationsForIndividual(individual: Individual) -> [Observation] {
        var selectedObs = [Observation]()
        
        for observation in observations {
            if observation.individual == individual {
                selectedObs.append(observation)
            }
        }
        return selectedObs
    }
    
    
    // MARK: METHODS FOR INDIVIDUALS
    
    
    /// This function bulk adds individuals to the session.
    func addIndividuals(individuals: [Individual]) {
        self._individuals += individuals
        updateSession()
    }
    
    /// This function updates the individual at the specified index.
    func updateIndividual(index: Int, updatedIndividual: Individual) {
        self._individuals.removeAtIndex(index)
        self._individuals.insert(updatedIndividual, atIndex: index)
        updateSession()
    }
    
    /// This function bulk removes the individuals at the specified indexes.
    func removeIndividuals(individualIndexes: [Int]) {
        // sort indexes in non-increasing order
        var decreasingIndexes = sorted(individualIndexes) { $0 > $1 }
        var prev = -1
        for (var i = 0; i < decreasingIndexes.count; i++) {
            let index = decreasingIndexes[i]
            if prev == index {
                continue;
            } else {
                prev = index
            }
            self._individuals.removeAtIndex(index)
        }
        updateSession()
    }
    
    /// This function sets the time interval for a session.
    func setInterval(interval: Int?) {
        _interval = interval
        updateSession()
    }
    
    /// This is a private function to update the instance's createdAt, createdBy
    /// updatedBy and updatedAt.
    private func updateSession() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user, updatedAt: NSDate())
    }

    
    // MARK: IMPLEMENTATION OF NSKEYEDARCHIVAL
    

    required init(coder aDecoder: NSCoder) {
        var enumerator: NSEnumerator
        
        self._typeValue = aDecoder.decodeObjectForKey(Session.typeValueKey) as! String
        self._name = aDecoder.decodeObjectForKey(Session.nameKey) as! String
        self._interval = aDecoder.decodeObjectForKey(Session.intervalKey) as? Int
        
        let objectObservations: AnyObject = aDecoder.decodeObjectForKey(
                                                    Session.observationsKey)!
        enumerator = objectObservations.objectEnumerator()
        self._observations = Array<Observation>()
        while true {
            var observation = enumerator.nextObject() as! Observation?
            if observation == nil {
                break
            }
            self._observations.append(observation!)
        }
        
        let objectIndividuals: AnyObject = aDecoder.decodeObjectForKey(
                                                    Session.individualsKey)!
        enumerator = objectIndividuals.objectEnumerator()
        self._individuals = Array<Individual>()
        
        while true {
            let individual = enumerator.nextObject() as! Individual?
            if individual == nil {
                break
            }
            self._individuals.append(individual!)
        }
        super.init(coder: aDecoder)
        
        for observation in self._observations {
            observation.setSession(self)
        }
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        // project attribute is allocated when project is initialized
        aCoder.encodeObject(_typeValue, forKey: Session.typeValueKey)
        aCoder.encodeObject(_name, forKey: Session.nameKey)
        aCoder.encodeObject(_interval, forKey: Session.intervalKey)
        aCoder.encodeObject(_observations, forKey: Session.observationsKey)
        aCoder.encodeObject(_individuals, forKey: Session.individualsKey)
    }
}

/// This function tests for session equality.
func ==(lhs: Session, rhs: Session) -> Bool {
    if lhs.name != rhs.name { return false }
    if lhs.type != rhs.type { return false }
    if lhs.interval != rhs.interval { return false }
    if lhs.project != rhs.project { return false }
    if lhs.observations.count != rhs.observations.count { return false }
    if lhs.individuals.count != rhs.individuals.count { return false }
    return true
}

/// This function tests for session inequality.
func !=(lhs: Session, rhs: Session) -> Bool {
    return !(lhs == rhs)
}

extension Session {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        // simple properties
        dictionary.setValue(_typeValue, forKey: Session.sessionTypeKey)
        dictionary.setValue(name, forKey: Session.nameKey)
        dictionary.setValue(_interval, forKey: Session.intervalKey)
        
        // complex properties
        var observationsArray = [NSDictionary]()
        for observation in observations {
            var observationDictionary = NSMutableDictionary()
            observation.encodeRecursivelyWithDictionary(observationDictionary)
            observationsArray.append(observationDictionary)
        }
        dictionary.setValue(observationsArray, forKey: Session.observationSetKey)

        var individualsArray = [NSDictionary]()
        for individual in individuals {
            var individualDictionary = NSMutableDictionary()
            individual.encodeRecursivelyWithDictionary(individualDictionary)
            individualsArray.append(individualDictionary)
        }
        dictionary.setValue(individualsArray, forKey: Session.individualsKey)
        
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}
