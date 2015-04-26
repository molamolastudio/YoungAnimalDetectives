//
//  sharedData.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 16/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Segue {
        static let DOG = "segue_dog"
        static let CAT = "segue_cat"
        static let GUINEAPIG = "segue_guineapig"
        static let RABBIT = "segue_rabbit"
        static let GO_OBSERVATIONS = "goToObservations"
    }
    
    struct Project {
        static let TITLE_DOG = "Title: Investigate a day in the life of a dog"
        static let TITLE_CAT = "Title: Investigate a day in the life of a cat"
        static let TITLE_GUINEAPIG = "Title: Investigate a day in the life of a guinea pig"
        static let TITLE_RABBIT = "Title: Investigate a day in the life of a rabbit"
        
        static let DOG = "project_dog"
        static let CAT = "project_cat"
        static let GUINEAPIG = "project_guineapig"
        static let RABBIT = "project_rabbit"
    }
    
    struct Image {
        static let SQUARE_DOG = "squarepup"
        static let SQUARE_CAT = "squarecat"
        static let SQUARE_GUINEAPIG = "squarepig"
        static let SQUARE_RABBIT = "squarerabbit"
    }
    
    struct Font {
        static let CHALKDUSTER = "Chalkduster"
    }
    
    struct Table {
        static let OBSERVATION_CELL_ID = "ObservationTableCell"
    }
    
    struct Words {
        static let OBS_FORM_DONE = "Done"
        static let SESSION_UNLIMITED = "Unlimited"
        static let PLACEHOLDER_INFO = "More information"
        static let EMPTY_STRING = ""
        static let OBS_FORM_TITLE = "Add information"
        static let OBS_FORM_CANCEL = "Cancel"
        static let OBS_FORM_ADD_TITLE = "Choose the behaviour state"
        static let OBS_FORM_RESET_TITLE = "Reset project"
        static let OBS_FORM_RESET_WARNING = "Once the project is deleted, it cannot be recovered. Do you want to proceed with reset?"
        static let PROJ_ALERT_DESTROY = "Destroy"
    }
    
    struct StorageKeys {
        static let PROJECT = "project"
        static let NICKNAME = "nickname"
        static let TYPE = "type"
        static let INDIVIDUAL = "individual"
    }
    
    struct Key {
        static let ID = "id"
        static let USER = "user"
        static let NAME = "name"
        static let EMAIL = "email"
        static let DEFAULT = "default"
        static let USERNAME = "username"
        static let CREATEDAT = "createdAt"
        static let CREATEDBY = "createdBy"
        static let UPDATEDAT = "updatedAt"
        static let UPDATEDBY = "updatedBy"
        static let CREATEDATDICT = "created_at"
        static let CREATEDBYDICT = "created_by"
        static let UPDATEDATDICT = "updated_at"
        static let UPDATEDBYDICT = "updated_by"
    }
}