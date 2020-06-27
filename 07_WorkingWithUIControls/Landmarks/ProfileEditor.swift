//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by 朱廷 on 2020/6/27.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username)
            }
            
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notification")
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Seasonal Photo").bold()
                
                Picker("Season Photo", selection: $profile.seasonalPhoto) {
                    ForEach(Profile.Season.allCases, id: \.self) { season in
                        Text(season.rawValue).tag(season)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.top)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Goal Date").bold()
                
                DatePicker("Goal Date",
                           selection: $profile.goalDate,
                           in: dateRange,
                           displayedComponents: .date)
            }
            .padding(.top)
            
            ZStack {
                Button("Tap Me") {
                    // action not working
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .onTapGesture {
                    self.startAnimation.toggle()
                    self.rotateDegree = self.startAnimation ? 360 : 0
                    if self.animationAmount > 0 {
                        self.animationAmount -= 1
                    }
                }
    //            .gesture(
    //                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10)
    //                    .onChanged { _ in
    //                        self.rotateDegree = 360.0
    //                    }
    //                    .onEnded {_ in
    //                        self.rotateDegree = 0.0
    //                    }
    //
    //            )
                .rotationEffect(Angle(degrees: rotateDegree), anchor: .center)
                .animation(repeatAnimation)
                
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(repeatAnimation)
                    .onAppear {
                        self.animationAmount = 2
                    }
            }
        }
    }
    
    var repeatAnimation: Animation? {
        if startAnimation {
            return Animation.linear(duration: 1).repeatCount(1000, autoreverses: false)
        } else {
            return .linear(duration: 0)
        }
    }
    
    @State private var rotateDegree: Double = 0
    @State private var animationAmount: CGFloat = 1
    @State private var startAnimation = true
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
