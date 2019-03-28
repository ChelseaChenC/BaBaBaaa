//
//  Message.swift
//  BaBaBaaa
//
//  Created by Chelsea Chen CHEN on 3/25/19.
//  Copyright © 2019 Chelsea Chen CHEN. All rights reserved.
//



import Foundation
import UIKit
import MessageKit

struct Message {
  let member: Member
  let text: String
  let messageId: String
}

extension Message: MessageType {
  
  var sender: Sender {
    return Sender(id: member.name, displayName: member.name)
  }
  
  var sentDate: Date {
    return Date()
  }
  
  var kind: MessageKind {
    return .text(text)
  }
}

struct Member {
  let name: String
  let avatar: String
}

extension Member {
  var toJSON: Any {
    return [
      "name": name,
      "avatar": avatar
    ]
  }
  
  init?(fromJSON json: Any) {
    guard
      let data = json as? [String: Any],
      let name = data["name"] as? String,
      let avatar = data["avatar"] as? String
      else {
        print("Couldn't parse Member")
        return nil
    }
    
    self.name = name
    self.avatar = avatar
  }
}

