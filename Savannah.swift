//
//  ContentView.swift
//  Coding
//
//  Created by Morten Schultz on 10/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI


//  3) Bruge en betingelse


// Datamodel
struct Sko: Identifiable {
    var id = UUID()
    var str: Int
    var model: String
    var pris: Int
    var lager: Bool
}

struct ContentView: View {
    
    // En variabel
    var sko = [
        Sko(str: 45, model: "Vans", pris: 499, lager: true),
        Sko(str: 42, model: "Nike", pris: 399, lager: false),
        Sko(str: 37, model: "Adidas", pris: 599, lager: false),
        Sko(str: 36, model: "Nike", pris: 599, lager: true)
    ]
    
    var body: some View {
        
        VStack {
            // Løkke
            List (sko) { sko in
                HStack {
                                                // Betingelse
                    Image(systemName: sko.lager ? "checkmark.circle.fill" : "circle")
                    
                    Text("\(sko.model)")
                    Text("\(sko.pris)")
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
