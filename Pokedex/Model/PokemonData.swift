//
//  PokemonData.swift
//  Pokedex
//
//  Created by PM Student on 11/9/22.
//

import Foundation


struct PokemonData: Decodable, Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    let type: String
    let weight: Float
    let height: Float
    let description: String
    let attack: Float
    let defense: Float
    let typeTwo: String
}

//let mockData: [PokemonData] = [
//    .init(id: 0, name: "Bulbasaur", type: "poison"),
//    .init(id: 1, name: "Ivysaur", type: "poison"),
//    .init(id: 2, name: "Charmander", type: "fire")]
