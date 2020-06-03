//
//  ContentView.swift
//  Prototype
//
//  Created by Morten Schultz on 03/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI


struct ShoppingList: Identifiable {
    var id = UUID()
    var titel: String
    var dato: String
    var varer: [String]
}

struct ContentView: View {
    
    var lister = [
        ShoppingList(titel: "Fakta", dato: "03-06-2020", varer: ["Sødmælk", "Æg", "Pasta"]),
        ShoppingList(titel: "Netto", dato: "12-05-2020", varer: ["Chokolade", "Saftevand", "Chips"])
        ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Indkøbsseddel")
                    .font(.largeTitle)
                
                List {
                    ForEach(lister) { liste in
                        NavigationLink(destination: Seddel(seddel: liste)) {
                            HStack {
                                Text(liste.titel)
                                Spacer()
                                Text(liste.dato)
                            }
                        }
                    }
                }
            }
        }
    }
}


struct Seddel: View {
    
    // Tag imod en liste
    var seddel: ShoppingList
    
    var body: some View {
        VStack {
            HStack {
                Text(seddel.titel)
                    .font(.title)
                Spacer()
                Text(seddel.dato)
                    .font(.system(size: 18))
            }
            .padding()
            
            List {
                ForEach(seddel.varer, id: \.self) { vare in
                    Text("\(vare)")
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
