//
//  RailFenceAlg.swift
//  Simple_Ciphers
//
//  Created by Kiryl Holubeu on 9/9/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

private extension String {
    subscript(i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

class RailFenceAlg {
    var key: Int
    
    init(key: Int) {
        self.key = key
    }
    
    // Return the number to step over the fence
    func getStep(iteration: Int, row: Int, size: Int) -> Int {
        if ((size == 0) || (size == 1)) {
            return 1
        }
        if ((row == 0) || (row == size-1)) {
            return (size-1)*2
        }
        if (iteration % 2 == 0) {
            return (size-1-row)*2
        }
        return 2*row
    }
    
    func encrypt(messageText: String) -> String {
        if (key > 0) {
            var encryptedMessage = ""
            for row in 0..<key {
                var iter = 0
                var i = row
                while i < messageText.count {
                    encryptedMessage.append(messageText[i])
                    i += getStep(iteration: iter, row: row, size: key)
                    iter += 1
                }
            }
            return encryptedMessage
        }
        return ""
    }
    
    func decrypt(encryptedText: String) -> String {
        if (key > 0) {
            var messageText = encryptedText
            var currPos = 0
            for row in 0..<key {
                var iter = 0
                var i = row
                while i < encryptedText.count {
                    messageText.remove(at: messageText.index(messageText.startIndex, offsetBy: i))
                    messageText.insert(encryptedText[currPos], at: messageText.index(messageText.startIndex, offsetBy: i))
                    currPos += 1
                    i += getStep(iteration: iter, row: row, size: key)
                    iter += 1
                }
            }
            return messageText
        }
        return ""
    }
}
