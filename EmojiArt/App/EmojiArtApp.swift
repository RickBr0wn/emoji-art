//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Rick Brown on 22/02/2021.
//

import SwiftUI

// App
@main
struct EmojiArtApp: App {
  @StateObject private var viewRouter = EmojiArtDocument()
  
  var body: some Scene {
    WindowGroup {
      EmojiArtDocumentView(document: viewRouter)
    }
  }
}
