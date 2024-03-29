//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by PM Student on 11/14/22.
//

import SwiftUI
import Kingfisher

struct PokemonDetails: View {
    
    let pokemonData: PokemonData
    let pokemonViewModel: PokemonViewModel
    let backgroundColor: Color
    let backgroundColorTwo: Color
    
    
    init(pokemonData: PokemonData, pokemonViewModel: PokemonViewModel) {
        self.pokemonData = pokemonData
        self.pokemonViewModel = pokemonViewModel
        self.backgroundColorTwo = Color(pokemonViewModel.detectBackgroundColor(forType: pokemonData.typeTwo))
        self.backgroundColor = Color(pokemonViewModel.detectBackgroundColor(forType: pokemonData.type))
    }
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                KFImage(URL(string: pokemonData.imageUrl))
                    .resizable()
                    .offset(y: 25)
                    .frame(width: 150, height: 150)
                    .zIndex(1)
                VStack(alignment: .leading) {
                    VStack(spacing: 15) {
                        Text("#" + String(pokemonData.id))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                            .padding(.top, 20)
                        Text(pokemonData.name.capitalized)
                            .font(.largeTitle)
                        
                         if pokemonData.type != pokemonData.typeTwo {
                        HStack {
                            Text(pokemonData.type.capitalized)
                                .font(.title2).bold()
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .fill(backgroundColor).opacity(0.3))
                                .frame(width:150, height: 40)
                                .background(backgroundColor)
                                .cornerRadius(20)
                            .shadow(color: backgroundColor, radius: 5)
                            
                            Text(pokemonData.typeTwo.capitalized)
                                .font(.title2).bold()
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .fill(backgroundColorTwo).opacity(0.3))
                                .frame(width:150, height: 40)
                                .background(backgroundColorTwo)
                                .cornerRadius(20)
                            .shadow(color: backgroundColorTwo, radius: 5)
                        }
                        } else {
                        Text(pokemonData.type.capitalized)
                            .font(.title2).bold()
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .fill(backgroundColor).opacity(0.3))
                            .frame(width:150, height: 40)
                            .background(backgroundColor)
                            .cornerRadius(20)
                        .shadow(color: backgroundColor, radius: 5)
                    }
                        HStack {
                            VStack {
                                HStack(alignment: .center, spacing: 5) {
                                    Text(String(pokemonData.height/10)).font(.title)
                                    Text("KG")
                                        .font(.subheadline)
                                        .fontWeight(.black)
                                        .foregroundColor(.gray)
                                }
                                Text("Weight")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            }
                            VStack {
                                HStack(alignment: .center, spacing: 5) {
                                    Text(String(pokemonData.weight/10))
                                        .font(.title)
                                    Text("Meter")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                                Text("Height")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        
                        Text(pokemonData.description)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray).bold()
                            .padding(.horizontal, 15)
                    }
                    VStack {
                        HStack {
                            Text("STATS")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                                .padding(.horizontal, 20)
                        }
                        VStack(spacing: 5) {
                            ForEach(0..<2) { i in
                                if( i == 0) {
                                    StatList(statusName: "atk", value: pokemonData.attack/100, color: backgroundColor)
                                }
                                else {
                                    StatList(statusName: "def", value: pokemonData.defense/100, color: backgroundColor)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(50.0)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct Meterbar: View {
    @Binding var value: Float
    @Binding var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(.systemGray))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(color)
                    .animation(.linear)
                    .cornerRadius(45)
            }
            .cornerRadius(45)
        }
    }
    
}


struct StatList: View {
    
    @State var statusName: String
    @State var value: Float
    @State var color: Color
    
    var body: some View {
        HStack {
            Text(statusName.uppercased())
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
                .padding(.horizontal, 20)
            Text(String(Int(value*100)))
            Meterbar(value: $value, color: $color).frame(height: 10)
                .padding(.trailing, 20)
        }
        .padding(.horizontal, 20)
    }
}


//struct PokemonDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonDetails()
//    }
//}
