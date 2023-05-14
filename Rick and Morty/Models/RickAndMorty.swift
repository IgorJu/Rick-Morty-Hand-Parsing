//
//  Character.swift
//  Rick and Morty
//
//  Created by Igor on 06.05.2023.
//

import Foundation

struct Personage: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    
    init(name: String, status: String, species: String, gender: String, image: String) {
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
    }
    
    init(from rickAndMorty: [String: Any]) {
        name = rickAndMorty["name"] as? String ?? ""
        status = rickAndMorty["status"] as? String ?? ""
        species = rickAndMorty["species"] as? String ?? ""
        gender = rickAndMorty["gender"] as? String ?? ""
        image = rickAndMorty["image"] as? String ?? ""
    }

    var description: String {
        """
    Name: \(name)
    Status: \(status)
    Spesies: \(species)
    Gender: \(gender)
    """
    }

    static func getPersonages(from value: Any) -> [Personage] {
        guard let data = value as? [String: Any] else { return [] }
        guard let results = data["results"] as? [Any] else { return [] }
        guard let personages = results as? [[String: Any]] else { return [] }
        
        return  personages.map { Personage(from: $0) }
    }
}


