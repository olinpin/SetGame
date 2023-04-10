//
//  SetApp.swift
//  Set
//
//  Created by Oliver Hnát on 08.04.2023.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(game: SetGameModelView())
        }
    }
}
