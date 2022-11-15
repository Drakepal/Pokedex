//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by PM Student on 11/9/22.
//

import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var pokemon = [PokemonData]()
    
    let apiURL = "https://firebasestorage.googleapis.com/v0/b/pokedex-83c1e.appspot.com/o/JSON8.json?alt=media&token=4af2c1e8-ab32-4b63-8e4b-ad27dec9c9e2"
    
    init() {
        fetchPokemonData()
    }
    
    func fetchPokemonData() {
        guard let url = URL(string: apiURL) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let cleanData = data?.parseData(removeString: "null,") else { return }
            
            DispatchQueue.main.async {
                do {
                    let pokemon = try JSONDecoder().decode([PokemonData].self, from: cleanData)
                    
                    self.pokemon = pokemon
                } catch {
                    print("error msg", error)
                }
            }
        }
        task.resume()
    }
    
    func detectBackgroundColor(forType type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "water": return .systemBlue
        case "poison": return .systemPurple
        case "electric": return .systemYellow
        case "psychic": return .systemPink
        case "normal": return .systemGray
        case "ground": return UIColor(Color("darkYellow"))
        case "fairy": return UIColor(Color("lightPink"))
        case "grass": return UIColor(Color("lightGreen"))
        case "bug": return .systemGreen
        case "flying": return UIColor(Color("lightBlue"))
        case "rock": return UIColor(Color("darkTan"))
        case "fighting": return .systemBrown
        case "steel": return UIColor(Color("silver"))
        case "ghost": return UIColor(Color("darkPurple"))
        case "dragon": return UIColor(Color("salmon"))
        case "ice": return .systemMint
        default: return .systemIndigo
        }
    }
}


extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString? .replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else {
            return nil
        }
        return data
    }
}
