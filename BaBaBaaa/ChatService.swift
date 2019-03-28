//
//  ChatService.swift
//  BaBaBaaa
//
//  Created by Chelsea Chen CHEN on 3/25/19.
//  Copyright © 2019 Chelsea Chen CHEN. All rights reserved.
//



import Foundation
import Scaledrone

class ChatService {
  
  private let scaledrone: Scaledrone
  private let messageCallback: (Message)-> Void
  
  private var room: ScaledroneRoom?
  
  init(member: Member, onRecievedMessage: @escaping (Message)-> Void) {
    self.messageCallback = onRecievedMessage
//    #error("Make sure to input your channel ID and delete this line.")
    self.scaledrone = Scaledrone(
      channelID: "lpJjtdv8SQi8K8BM",
      data: member.toJSON)
    scaledrone.delegate = self
  }
  
  func connect() {
    scaledrone.connect()
  }
  
// we also need to send the messages
  func sendMessage(_ message: String) {
    let baa = "B" + String(repeating: "a", count: message.count)
    room?.publish(message: baa)
  }
  
}

//A room is a group of users that we can send messages to. You listen to those messages by subscribing to a room of a specific name.

extension ChatService: ScaledroneDelegate {
  
  func scaledroneDidConnect(scaledrone: Scaledrone, error: NSError?) {
    print("Connected to Scaledrone")
    room = scaledrone.subscribe(roomName: "observable-room")
    room?.delegate = self
  }
  
  func scaledroneDidReceiveError(scaledrone: Scaledrone, error: NSError?) {
    print("Scaledrone error", error ?? "")
  }
  
  func scaledroneDidDisconnect(scaledrone: Scaledrone, error: NSError?) {
    print("Scaledrone disconnected", error ?? "")
  }
  
}


//To listen to new messages
extension ChatService: ScaledroneRoomDelegate {
  
  func scaledroneRoomDidConnect(room: ScaledroneRoom, error: NSError?) {
    print("Connected to room!")
  }
  
  func scaledroneRoomDidReceiveMessage(
    room: ScaledroneRoom,
    message: Any,
    member: ScaledroneMember?) {
    
    guard
      let text = message as? String,
      let memberData = member?.clientData,
      let member = Member(fromJSON: memberData)
      else {
        print("Could not parse data.")
        return
    }
    
//When we receive a new message, we'll try to convert it into a String. We then create a Member from the data we received in the function
    
    let message = Message(
      member: member,
      text: text,
      messageId: UUID().uuidString)
    messageCallback(message)
  }
}

