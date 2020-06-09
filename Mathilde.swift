//
//  ContentView.swift
//  CodingForFun
//
//  Created by Morten Schultz on 09/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI

// Datamodel
struct Seddel: Identifiable {
    var id = UUID()
    var titel: String
    var vare: [String]
    var placering: [String]
    var udfoert: Bool
}

struct ContentView: View {
    
    // Variabel
    var sedler = [
        Seddel(titel: "Fest", vare: ["Snacks", "Alkohol", "Sodavand"], placering: ["Netto", "Fakta"], udfoert: false),
        Seddel(titel: "Studentergilde", vare: ["Hatte", "Dug", "Sodavand"], placering: ["Bilka", "Rema"], udfoert: false),
        Seddel(titel: "Studentergilde", vare: ["Hatte", "Dug", "Sodavand"], placering: ["Bilka", "Rema"], udfoert: true)
    ]
    
    var body: some View {
        VStack {
            // Løkke
            List(sedler) { seddel in
                HStack {
                    Image(systemName: seddel.udfoert ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(seddel.udfoert ? .green : .black)
                    Text(seddel.titel)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
