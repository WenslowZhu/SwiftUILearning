//
//  UserData.swift
//  Landmarks
//
//  Created by 朱廷 on 2020/6/26.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
