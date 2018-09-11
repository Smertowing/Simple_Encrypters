//
//  CardanGrilleAlg.swift
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

class SquareAlg {
    typealias MatrixOfChar = [[Character]]    
    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var key = [(0,0),(3,1),(2,2),(1,3)]
    var length = 4
    
    
    // for non typical task (not 4x4 square)
    init(key: [(Int,Int)]) {
        self.key = key
        self.length = key.count
    }
    
    init() {

    }
    
    // Rotate position of "holes" to the right
    func getIndexs(iteration: Int) -> [(Int,Int)] {
        var temp = Array(repeating: (0,0), count: length)
        for elem in key {
            var x, y: Int
            if ((iteration == 0) || (iteration == 3)) {
                x = elem.0
            } else {
                x = (length-1) - elem.0
            }
            if (iteration <= 1) {
                y = elem.1
            } else {
                y = length - 1 - elem.1
            }
            let el = (x,y)
            temp[el.1] = el
        }
        return temp
    }
    
    // Complete the string to a size suitable for encrypting
    func fillString(s: String, amountNeeded: Int) -> String {
        var index = 0
        var temp = s
        while (temp.count % amountNeeded) != 0 {
            temp.append(alphabet[index % alphabet.count])
            index += 1
        }
        return temp
    }
    
    func encryptWithSquare(message: String) -> String {
        var matrix: MatrixOfChar = Array(repeating: Array(repeating: "X" , count: length), count: length)
        var currIndex = 0
        for i in 0..<matrix.count {
            let newIndexs = getIndexs(iteration: i)
            for indexs in newIndexs {
                matrix[indexs.1][indexs.0] = message[currIndex]
                currIndex += 1
            }
        }
        var cipherText = ""
        for i in 0..<length {
            for j in 0..<length {
                cipherText.append(matrix[i][j])
            }
        }
        return cipherText
    }
    
    func encrypt(messageText: String) -> String {
        var tempMessage = fillString(s: messageText, amountNeeded: length*length)
        var cipherText = ""
        var tempString = ""
        while tempMessage.count != 0 {
            for _ in 0..<length*length {
                tempString.append(tempMessage.removeFirst())
            }
            cipherText += encryptWithSquare(message: tempString)
        }
        return cipherText
    }
    
    func decryptWithSquare(message: String) -> String {
        var matrix: MatrixOfChar = Array(repeating: Array(repeating: "X" , count: length), count: length)
        var cipherText = message
        for i in 0..<length {
            for j in 0..<length {
                matrix[i][j] = cipherText.removeFirst()
            }
        }
        var messageText = ""
        for i in 0..<matrix.count {
            let newIndexs = getIndexs(iteration: i)
            for indexs in newIndexs {
                messageText.append(matrix[indexs.1][indexs.0])
            }
        }
        return messageText
    }
    
    func decrypt(encryptedText: String) -> String {
        var tempMessage = fillString(s: encryptedText, amountNeeded: length*length)
        var messageText = ""
        var tempString = ""
        while tempMessage.count != 0 {
            for _ in 0..<length*length {
                tempString.append(tempMessage.removeFirst())
            }
            messageText += decryptWithSquare(message: tempString)
        }
        return messageText
    }
}
