//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Rick Brown on 22/02/2021.
//

import SwiftUI

// View
struct EmojiArtDocumentView: View {
  @ObservedObject var document: EmojiArtDocument
  
  var body: some View {
    VStack {
      ScrollView(.horizontal) {
        HStack {
          /*
           loop through a string with:
           EmojiArtDocument.palette.map { String($0) }
           */
          ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self) { emoji in
            Text(emoji)
              .font(.system(size: Dimensions.Defaults.emojiSize))
              .onDrag { NSItemProvider(object: emoji as NSString) }
          }
        }
      }
      .padding(.horizontal)
      
      ZStack {
        GeometryReader { geometry in
          Color.white.overlay(
            Group {
              if self.document.backgroundImage != nil {
                Image(uiImage: self.document.backgroundImage!)
              }
            })
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .onDrop(of: ["public.image", "public.text"], isTargeted: nil, perform: { providers, location in
              var location = geometry.convert(location, from: .global)
              location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height / 2)
              return self.drop(providers: providers, at: location)
            })
          
          ForEach(self.document.emojis) { emoji in
            Text(emoji.text)
              .font(self.font(for: emoji))
              .position(self.position(for: emoji, in: geometry.size))
          }
        }
      }
    }
  }
  
  private func font(for emoji: EmojiArt.Emoji) -> Font {
    Font.system(size: emoji.fontSize)
  }
  
  private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
    CGPoint(x: emoji.location.x + size.width / 2, y: emoji.location.y + size.height / 2)
  }
  
  private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
    var found = providers.loadFirstObject(ofType: URL.self) { url in
      self.document.setBackground(url)
    }
    if !found {
      found = providers.loadObjects(ofType: String.self, using: { string in
        self.document.addEmoji(string, at: location, size: 40)
      })
    }
    return found
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiArtDocumentView(document: EmojiArtDocument())
  }
}
