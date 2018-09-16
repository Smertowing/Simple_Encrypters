//
//  VigenereAlg.swift
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

class VigenereAlg {
    let alphabet: String
    let alphabetSize: Int
    var key: String
    let keySize: Int
    
    init(key: String) {
        self.alphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
        self.alphabetSize = alphabet.count
        self.key = key.uppercased()
        self.keySize = key.count
    }
    
    // Returns index of the symbol in alphabet
    private func indexOfAlphabet(forCharacter character: Character) -> Int {
        var index = 0
        
        for chr in alphabet {
            if chr == character {
                return index
            }
            index += 1
        }
        
        return -1
    }
    
    func encrypt(messageText: String) -> String {
        var encryptedText = ""
        var keyIndex = 0
        for character in messageText {
            let indexInAlphabet = indexOfAlphabet(forCharacter: character)
            
            if indexInAlphabet == -1 {
                continue
            }
            
            if keyIndex == keySize {
                var newKey = ""
                for char in key {
                    newKey.append(alphabet[(indexOfAlphabet(forCharacter:char)+1) % alphabetSize])
                }
                key = newKey
                keyIndex = 0
            }
            
            let keyToEncryptWith = key[keyIndex]
            let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
            let encryptedLetterIndex = (indexInAlphabet + keyIndexInAlphabet + alphabetSize) % alphabetSize
            encryptedText.append(alphabet[encryptedLetterIndex])
            keyIndex += 1
        }
        
        return encryptedText
    }
    
    func decrypt(encryptedText: String) -> String {
        var decryptedText = ""
        var keyIndex = 0
        
        for character in encryptedText {
            let indexInAlphabet = indexOfAlphabet(forCharacter: character)
            
            if indexInAlphabet == -1 {
                continue
            }
            
            if keyIndex == keySize {
                var newKey = ""
                for char in key {
                    newKey.append(alphabet[(indexOfAlphabet(forCharacter:char)+1) % alphabetSize])
                }
                key = newKey
                keyIndex = 0
            }
            
            let keyToDecryptWith = key[keyIndex]
            let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToDecryptWith)
            let encryptedLetterIndex = (indexInAlphabet - keyIndexInAlphabet + alphabetSize) % alphabetSize
            decryptedText.append(alphabet[encryptedLetterIndex])
            keyIndex += 1
        }
        
        return decryptedText
    }
}
