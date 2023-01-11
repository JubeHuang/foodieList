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
    let address: String
    let phone: String
    let googleLink: URL?
    let caption: String
    var imageName: String
    let comment: String
    
    static let unComment = "尚未給予評論..."
    
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
    static let documentDirectoryChecked = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let documentDirectoryUnChecked = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    
    static func loadCheckedInfo()-> [Info]? {
        let decoder = JSONDecoder()
        let url = documentDirectoryChecked.appendingPathComponent("checkedInfo")
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? decoder.decode([Info].self, from: data)
    }
    
    static func loadUnCheckedInfo() -> [Info]? {
        let decoder = JSONDecoder()
        let url = documentDirectoryUnChecked.appendingPathComponent("unCheckedInfo")
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? decoder.decode([Info].self, from: data)
    }
    
    static func saveCheckedInfo(Infos: [Info]){
        let encoder = JSONEncoder()
        let url = documentDirectoryChecked.appendingPathComponent("checkedInfo")
        let data = try? encoder.encode(Infos)
        try? data?.write(to: url)
    }
    
    static func saveUnCheckedInfo(infos: [Info]) {
        let encoder = JSONEncoder()
        let url = documentDirectoryUnChecked.appendingPathComponent("unCheckedInfo")
        let data = try? encoder.encode(infos)
        try? data?.write(to: url)
    }
}
