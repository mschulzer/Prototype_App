//
//  ContentView.swift
//  EasyDoesIt
//
//  Created by Morten Schultz on 09/06/2020.
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
    @State var myTxt: String = ""
    @State var showSheet = false
    @State var showAdd = false
    
    // A bit of dummy data
    @State var activities = [
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
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAdd.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }.sheet(isPresented: $showAdd, content: {
                    SheetAdd(showAdd: self.$showAdd, didAddActivity: {
                        activity in
                        self.activities.append(activity)
                    })
                })
            )
        }
    }
}

// MARK:- Custom views
struct ShowCell: View {
    
    @ObservedObject var activity: Activity
    
    var body: some View {
        HStack {
            Button(action: {
                //self.activity.completed.toggle()
            }) {
                Image(systemName: activity.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(activity.completed ? .green : .black)
                    
            }.onTapGesture {
                self.activity.completed.toggle()
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

struct SheetAdd: View {
    
    @State private var title: String = ""
    @State private var priority: String = ""
    @Binding var showAdd: Bool
    
    var didAddActivity: (Activity) -> ()
    
    var body: some View {
        VStack {
            TextField("Enter activity", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
            TextField("Enter priority", text: $priority)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
            
            Button(action: {
                self.didAddActivity(.init(title: self.title, priority: Int(self.priority) ?? 0, completed: false))
                self.showAdd = false
            }){
                Text("Add activity")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(40)
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
                        Image(systemName: activity.completed ? "checkmark.circle.fill" : "circle")
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
