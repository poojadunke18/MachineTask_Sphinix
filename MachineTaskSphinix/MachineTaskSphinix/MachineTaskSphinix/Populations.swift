//
//  Populations.swift
//  MachineTaskSphinix
//
//  Created by Mac on 21/03/23.
//

import Foundation
struct Populationsdatamodel : Decodable{
    let data : [Populations]
    enum CodingKeys :  CodingKey {
        case data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([Populations].self, forKey: .data)
    }
}
struct Populations : Decodable{
    let population : Int
    let year : String
    enum PopulationKeys : String, CodingKey {
        case population = "Population"
        case year = "Year"
    }
    init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: PopulationKeys.self)
            population = try container.decode(Int.self, forKey: .population)
            year = try container.decode(String.self, forKey: .year)
        }
    }

