//
//  ViewController.swift
//  BaBaBaaa
//
//  Created by Chelsea Chen CHEN on 3/25/19.
//  Copyright © 2019 Chelsea Chen CHEN. All rights reserved.
//

import UIKit
import MessageKit

class ViewController: MessagesViewController {

  var chatService: ChatService!
  var messages: [Message] = []
  var member: Member!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    member = Member(name: .randomName, avatar: .randomAvatar)
    messagesCollectionView.messagesDataSource = self
    messagesCollectionView.messagesLayoutDelegate = self
    messageInputBar.delegate = self
    messagesCollectionView.messagesDisplayDelegate = self
    
    chatService = ChatService(member: member, onRecievedMessage: {
      [weak self] message in
      self?.messages.append(message)
      self?.messagesCollectionView.reloadData()
      self?.messagesCollectionView.scrollToBottom(animated: true)
    })
    
    chatService.connect()
  }


}

//First we create a Sender instance from our member. Then, we return the number of the messages. Each section contains a new message, so we simply return the message for that section index. Lastly, we return an attributed text containing the username of the sender for a label above the message.
extension ViewController: MessagesDataSource {
  func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
    return messages.count
  }
  
  func currentSender() -> Sender {
    return Sender(id: member.name, displayName: member.name)
  }
  
  func messageForItem(at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageType {
    
    return messages[indexPath.section]
  }
  
  func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
    return 24
  }
  
  func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
    return NSAttributedString(
      string: message.sender.displayName,
      attributes: [.font: UIFont.systemFont(ofSize: 12)])
  }
}

extension ViewController: MessagesLayoutDelegate {
  func heightForLocation(message: MessageType,
                         at indexPath: IndexPath,
                         with maxWidth: CGFloat,
                         in messagesCollectionView: MessagesCollectionView) -> CGFloat {
    return 2
  }
}

extension ViewController: MessagesDisplayDelegate {
  func configureAvatarView(
    _ avatarView: AvatarView,
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) {
    
    let message = messages[indexPath.section]
    let ima = message.member.avatar
    avatarView.image = UIImage(named: ima)

    }
}


//this allows us to actually send a new message.
extension ViewController: MessageInputBarDelegate {
  func messageInputBar(
    _ inputBar: MessageInputBar,
    didPressSendButtonWith text: String) {
    
    chatService.sendMessage(text)
    inputBar.inputTextView.text = ""
  }
}

