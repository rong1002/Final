//
//  ProFIleData.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/6.
//

import SwiftUI

struct Person: Codable,Identifiable {
    var id = UUID()
    var username = ""
    var email = ""
    var birth: Date

}

class Peopledata : ObservableObject{
    @Published var people = [Person](){
        didSet{
            let encoder=JSONEncoder()
            if let data = try? encoder.encode(people){
                UserDefaults.standard.set(data,forKey: "people")
            }
        }
    }
    init(){
        if let data = UserDefaults.standard.data(forKey: "people"){
            let decorder=JSONDecoder()
            if let decodeData = try? decorder.decode([Person].self, from: data){
                people = decodeData
            }
        }
        if people.count==0{
                    people.append(Person(username: "", email: "", birth: Date.init()))
        }
    }
    
}

struct Photo: Codable {
    var content: String
    var imageName: String
    
    var imagePath: String {
        return PhotoData.documentsDirectory.appendingPathComponent(imageName).path
    }
}

class PhotoData: ObservableObject {

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    @Published var photos = [Photo]() {
        didSet {
            if let data = try? PropertyListEncoder().encode(photos) {
                let url = PhotoData.documentsDirectory.appendingPathComponent("photos")
                try? data.write(to: url)
            }
        }
    }
    init() {
               let url = PhotoData.documentsDirectory.appendingPathComponent("photos")
               if let data = try? Data(contentsOf: url), let array = try?  PropertyListDecoder().decode([Photo].self, from: data) {
                   photos = array
               }
           }
}


