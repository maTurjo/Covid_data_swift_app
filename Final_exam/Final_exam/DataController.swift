//
//  DataController.swift
//  Final_exam
//
//  Created by user202461 on 4/20/22.
//

import UIKit
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let id, displayName: String?
    let areas: [Welcome]?
    let totalConfirmed: Int?
    let totalDeaths, totalRecovered, totalRecoveredDelta, totalDeathsDelta: Int?
    let totalConfirmedDelta: Int?
    let lastUpdated: LastUpdated?
    let lat, long: Double?
    let parentID: String?

    enum CodingKeys: String, CodingKey {
        case id, displayName, areas, totalConfirmed, totalDeaths, totalRecovered, totalRecoveredDelta, totalDeathsDelta, totalConfirmedDelta, lastUpdated, lat, long
        case parentID = "parentId"
    }
}

enum LastUpdated: String, Codable {
    case the20200413T025727092Z = "2020-04-13T02:57:27.092Z"
}


class DataController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
