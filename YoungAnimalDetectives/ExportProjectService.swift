//
//  ExportObservationsService.swift
//  BioLifeTracker
//
//  Created by Li Jia'En, Nicholette on 12/4/15.
//  Copyright (c) 2015 Mola Mola Studios. All rights reserved.
//

import Foundation
import UIKit

class ExportObservationsService {
    var project: Project
    var serializedProjectPath: NSURL?
    static var documentInteractionVC: UIDocumentInteractionController!
    
    init(project: Project) {
        self.project = project
        let serializer = BLTProjectSerializer(project: project)
        serializedProjectPath = serializer.writeToFileAndRetrieveFileUrl(fileName: project.name)
    }
    
    func openInOtherApps(button: UIButton) {
        if let fileURL = serializedProjectPath {
            ExportObservationsService.documentInteractionVC = UIDocumentInteractionController(URL: fileURL)
            ExportObservationsService.documentInteractionVC.UTI = "public.comma-separated-values-text"
            ExportObservationsService.documentInteractionVC.presentOpenInMenuFromRect(CGRect(x: 70.0, y: 36.0, width: 0.0, height: 0.0), inView: button, animated: true)
        }
    }
}

