//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Rick Brown on 22/02/2021.
//

import Foundation

struct EmojiArt {
  var backgroundURL: URL?
  // this variable chould be protected and no mutation should occur from outsife of this struct
  var emojis = [Emoji]()
  
  struct Emoji: Identifiable {
    let text: String
    var x: Int
    var y: Int
    var size: Int
    let id: Int
    
    /*
     fileprivate: scoped to EmojiArt - protect the emojis array from being mutated from anything outside of this file
     private: scoped to Emoji - using just private here would not of worked
     */
    fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
      self.text = text
      self.x = x
      self.y = y
      self.size = size
      self.id = id
    }
  }
  
  /*
   privately declared variable to be used as an id counter
   */
  private var uniqueEmojiId = 0
  /*
   increment the uniqueEmojiId and create the Emoji
   */
  mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
    uniqueEmojiId += 1
    emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
  }
}
