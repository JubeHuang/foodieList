//
//  Info.swift
//  foodieList
//
//  Created by Jube on 2023/1/6.
//

import Foundation

struct Info: Codable {
    //information
    let name: String
    let basicInfo: BasicInfo?
    let imageName: String
    let comment: String
    
    static let unComment = "尚未給予評論..."
    
        struct BasicInfo: Codable {
            let address: String
            let phone: String
            let googleLink: URL?
            let caption: String
        }
    
    //checked & btn
    var checked: Bool
    var btnImageName: String {
        get {
            self.checked ? "checked" : "unChecked"
        } set {
            self.checked = newValue == "checked" ? true : false
        }
    }
    
    //saveInfoToLocal
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static func loadInfo()-> [Info]? {
        let decoder = JSONDecoder()
        let url = documentDirectory.appendingPathComponent("infos")
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? decoder.decode([Info].self, from: data)
    }
    static func saveInfo(Infos: [Info]){
        let encoder = JSONEncoder()
        let url = documentDirectory.appendingPathComponent("infos")
        let data = try? encoder.encode(Infos)
        try? data?.write(to: url)
    }
}
