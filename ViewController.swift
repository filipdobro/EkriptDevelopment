//
//  ViewController.swift
//  Metalldetektor
//
//  Created by EKRIPTD on 23.09.17.
//  Copyright © 2017 ekript.development. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

struct LogEntry: Codable{
    let task: String?
    let solution: String?
}

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var progressBar: UIProgressView!
    var locationManager: CLLocationManager!
    
    @IBAction func logSolution(_ sender: Any) {
        let solutionLogger = SolutionLogger(viewController: self)
        solutionLogger.scanQRCode{ code in
            let entry = LogEntry(task: "Metalldetektor", solution: code)
            solutionLogger.logSolution(entry)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading
        newHeading: CLHeading) {
        
        let x = newHeading.x
        let y = newHeading.y
        let z = newHeading.z
        let magnitude = sqrt(x*x + y*y + z*z)
        
        let maxMagnitude = 4000.0
        let magnitudeRatio = magnitude / maxMagnitude
        
        
        progressBar.progress = Float(magnitudeRatio)

    }
    

}

