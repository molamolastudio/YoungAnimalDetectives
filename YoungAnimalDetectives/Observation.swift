//
//  Observation.swift
//  BioLifeTracker
//
//  Created by Michelle Tan on 10/3/15.
//  Maintained by Li Jia'En, Nicholette.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation

//  This is a data model class for Observation.
//  This class contains methods to initialise Observation instances,
//  get and set instance attributes.
//  This class also contains methods to store and retrieve saved
//  Observation instances to the disk.
class Observation: Model, BLTObservationProtocol {
    // Constants
    static let timestampKey = "timestamp"
    static let informationKey = "information"
    static let recordedBehaviourKey = "recorded_behaviour"
    static let locationKey = "location"
    static let weatherKey = "weather"
    static let photoKey = "photo"
    static let individualKey = "individual"
    static let sessionKey = "session"
    static let stateKey = "state"
    
    static let ClassUrl = "observations"
    
    // Private attributes
    private var _session: Session!
    private var _state: BehaviourState
    private var _information: String
    private var _timestamp: NSDate
    private var _photo: Photo?
    private var _individual: Individual?
    private var _location: Location?
    private var _weather: Weather?
    
    // Accessors
    var session: Session! { get { return _session } }
    var state: BehaviourState { get { return _state } }
    var information: String { get { return _information } }
    var timestamp: NSDate { get { return _timestamp } }
    var photo: Photo? { get { return _photo } }
    var individual: Individual? { get { return _individual } }
    var location: Location? { get { return _location } }
    var weather: Weather? { get { return _weather } }
    
    /// This is an overload function to initialise an Observation instance.
    init(session: Session, individual: Individual, state: BehaviourState,
                                    timestamp: NSDate, information: String) {
        self._session = session
        self._state = state
        self._timestamp = timestamp
        self._location = Location()
        self._weather = Weather()
        self._information = information
        self._individual = individual
        super.init()
    }
    
    /// This is an overload function to initialise an Observation instance.
    init(session: Session, state: BehaviourState, timestamp: NSDate,
                                                        information: String) {
        self._session = session
        self._state = state
        self._timestamp = timestamp
        self._location = Location()
        self._weather = Weather()
        self._information = information
        super.init()
    }

    
    // MARK: METHOD FOR OBSERVAIONS
    
    /// This function sets the session owner of the observation.
    /// To be called by Session instance during decoding
    func setSession(session: Session) {
        self._session = session
    }
    
    /// This function changes the behaviour state of the observation
    func changeBehaviourState(state: BehaviourState) {
        self._state = state
        updateObservation()
    }
    
    /// This function updates the information of the observation.
    func updateInformation(information: String) {
        self._information = information
        updateObservation()
    }
    
    /// This function updates the photo of the instance.
    func updatePhoto(photo: Photo?) {
        self._photo = photo
        updateObservation()
    }
    
    /// This function changes the individual of the observation.
    func changeIndividual(individual: Individual) {
        self._individual = individual
        updateObservation()
    }
    
    /// This function changes the location of the observation.
    func changeLocation(location: Location) {
        self._location = location
        updateObservation()
    }
    
    /// This function changes the weather of the observation.
    func changeWeather(weather: Weather) {
        self._weather = weather
        updateObservation()
    }
    
    /// This is a private function to update the instance's createdAt, createdBy
    /// updatedBy and updatedAt.
    private func updateObservation() {
        updateInfo(updatedBy: UserAuthService.sharedInstance.user, updatedAt: NSDate())
    }

    
    // MARK: IMPLEMENTATION OF NSKEYEDARCHIVAL
    
    
    required init(coder aDecoder: NSCoder) {
        var enumerator: NSEnumerator
        
        self._state = aDecoder.decodeObjectForKey(Observation.stateKey) as! BehaviourState
        self._timestamp = aDecoder.decodeObjectForKey(Observation.timestampKey) as! NSDate
        self._location = aDecoder.decodeObjectForKey(Observation.locationKey) as? Location
        self._weather = aDecoder.decodeObjectForKey(Observation.weatherKey) as? Weather
        self._individual = aDecoder.decodeObjectForKey(Observation.individualKey) as? Individual
        self._information = aDecoder.decodeObjectForKey(Observation.informationKey) as! String
        self._photo = aDecoder.decodeObjectForKey(Observation.photoKey) as? Photo
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(_session, forKey: Observation.sessionKey)
        aCoder.encodeObject(_state, forKey: Observation.stateKey)
        aCoder.encodeObject(_timestamp, forKey: Observation.timestampKey)
        aCoder.encodeObject(_location, forKey: Observation.locationKey)
        aCoder.encodeObject(_weather, forKey: Observation.weatherKey)
        aCoder.encodeObject(_individual, forKey: Observation.individualKey)
        aCoder.encodeObject(_information, forKey: Observation.informationKey)
        aCoder.encodeObject(_photo, forKey: Observation.photoKey)
    }
}

/// This function tests for observation inequality.
func !=(lhs: Observation, rhs: Observation) -> Bool {
    return !(lhs == rhs)
}

extension Observation {
    override func encodeRecursivelyWithDictionary(dictionary: NSMutableDictionary) {
        // simple properties
        dictionary.setValue(information, forKey: Observation.informationKey)
        dictionary.setValue(timestamp.toBiolifeDateFormat(), forKey: Observation.timestampKey)
        
        // complex properties
        var stateDictionary = NSMutableDictionary()
        state.encodeRecursivelyWithDictionary(stateDictionary)
        dictionary.setValue(stateDictionary, forKey: Observation.recordedBehaviourKey)
        
        // optional complex properties
        if let photo = photo {
            var photoDictionary = NSMutableDictionary()
            photo.encodeRecursivelyWithDictionary(dictionary)
            dictionary.setValue(photoDictionary, forKey: Observation.photoKey)
        }
        if let individual = individual {
            var individualDictionary = NSMutableDictionary()
            individual.encodeRecursivelyWithDictionary(individualDictionary)
            dictionary.setValue(individualDictionary, forKey: Observation.individualKey)
        }
        if let location = location {
            var locationDictionary = NSMutableDictionary()
            location.encodeRecursivelyWithDictionary(locationDictionary)
            dictionary.setValue(locationDictionary, forKey: Observation.locationKey)
        }
        if let weather = weather {
            var weatherDictionary = NSMutableDictionary()
            weather.encodeRecursivelyWithDictionary(weatherDictionary)
            dictionary.setValue(weatherDictionary, forKey: Observation.weatherKey)
        }
        super.encodeRecursivelyWithDictionary(dictionary)
    }
}
