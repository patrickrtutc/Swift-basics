//
//  ListView.swift
//  FirstSwiftUIProject
//
//  Created by Patrick Tung on 2/21/25.
//

import SwiftUI

struct ListView: View {
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        VStack {
            List(months, id: \.self) { month in
                Section("Months") {
                    ForEach(months, id: \.self) {
                        month in ListCellView(data: month)
                    }
                }
                Section("Weekdays") {
                    ForEach(weekDays, id: \.self) {
                        day in HStack {
                            Text(day).font(.title)
                            Image(systemName: "person.circle.fill")
                        }.foregroundStyle(.red).onTapGesture {
                            print(day)
                        }
                    }
                }
                HStack {
                    Image(systemName: "figure.hiking").resizable().frame(width: 30, height: 30).padding(.trailing)
                    Text(month)
                }.padding(.bottom, 4)
            }
        }.listStyle(.insetGrouped).navigationTitle("ListView").navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ListView()
}
