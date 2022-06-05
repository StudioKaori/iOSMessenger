//
//  ChatViewController.swift
//  Messenger
//
//  Created by Kaori Persson on 2022-06-05.
//

import UIKit
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
    

}
