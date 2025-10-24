//
//  AppModel.swift
//  My-iOS-Apps
//
//  Created by Sthuthi S on 24/10/25.
//

import Foundation

struct AppModel: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let version: String
    let imageName: String
    
    init(id: UUID = UUID(), name: String, version: String, imageName: String) {
        self.id = id
        self.name = name
        self.version = version
        self.imageName = imageName
    }
}

let timerApp = AppModel(name: "Timer App", version: "1.0", imageName: "Timer-Logo")

let currentApps: [AppModel] = [timerApp]
