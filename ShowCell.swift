//
//  ContentView.swift
//  EasyDoesIt
//
//  Created by Morten Schultz on 06/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI

// MARK:- Datamodel
class Activity: Identifiable, ObservableObject {
    
    var title: String
    var priority: Int
    @Published var completed: Bool
    
    init(title: String, priority: Int, completed: Bool) {
        self.title = title
        self.priority = priority
        self.completed = completed
    }
}

struct ContentView: View {
    
    @State var showSheet = false
    
    // A bit of dummy data
    var activities = [
        Activity(title: "Go running", priority: 3, completed: true),
        Activity(title: "Write paper", priority: 5, completed: true),
        Activity(title: "Buy food", priority: 2, completed: false),
        Activity(title: "Call work", priority: 1, completed: false)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List(activities) { act in
                    ShowCell(activity: act)
                }
                
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    Text("Show details")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                    
                }.padding(.bottom, 20)
            }
            .sheet(isPresented: $showSheet, content: {
                SheetView(activities: self.activities)
            })
        .navigationBarTitle("My Activities")
        }
    }
}

struct ShowCell: View {
    
    @ObservedObject var activity: Activity
    
    var body: some View {
        HStack {
            Button(action: {
                self.activity.completed.toggle()
            }) {
                Image(systemName: activity.completed ? "checkmark.circle.fill" : "checkmark.circle")
                    .foregroundColor(activity.completed ? .green : .black)
            }
            Text(activity.title)
            
            Spacer()
            
            ForEach(0..<activity.priority) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
            }
        }
    }
}

struct SheetView: View {
    
    var activities: [Activity]
    
    var body: some View {
        VStack {
            List {
                ForEach(activities) { activity in
                    HStack {
                        Image(systemName: activity.completed ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(activity.completed ? .green : .black)
                        Text("\(activity.title)")
                    }
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
