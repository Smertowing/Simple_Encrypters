//
//  Vigenere.swift
//  Simple_Ciphers
//
//  Created by Kiryl Holubeu on 9/10/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Cocoa

class Vigenere: NSViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var path: String = ""
    var fileURLZ  = URL(fileURLWithPath: "")
    var messageText  = ""
    var cipherText = ""
    var keyword    = ""
    let russianAlphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
    
    func browseFile(sender: AnyObject) -> String {
        let browse = NSOpenPanel()
        browse.title                   = "Choose a .txt file"
        browse.showsResizeIndicator    = true
        browse.canChooseDirectories    = false
        browse.canCreateDirectories    = true
        browse.allowsMultipleSelection = false
        browse.allowedFileTypes = ["txt"]
        if (browse.runModal() == NSApplication.ModalResponse.OK) {
            let result = browse.url
            
            if (result != nil) {
                path = result!.path
                return path
            }
        } else {
            return ""
        }
        return ""
    }
    
    func dialogError(question: String, text: String) {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .critical
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @IBOutlet weak var originalMessageField: NSTextField!
    @IBOutlet weak var encryptedMessageField: NSTextField!
    @IBOutlet weak var keywordField: NSTextField!
    
    @IBAction func encodeBtn(_ sender: Any) {
        messageText = (originalMessageField.stringValue.uppercased()).filter{ return russianAlphabet.contains($0) }
        if messageText == "" {
            dialogError(question: "Your message is an empty!", text: "Error: Nothing to encode.")
            return
        }
        
        keyword = keywordField.stringValue
        keyword = keyword.uppercased()
        let filteredKeyword = keyword.filter { return russianAlphabet.contains($0) }
        keyword = String(filteredKeyword)
        keywordField.stringValue = keyword
        if keyword == "" {
            dialogError(question: "Please, specify the keyword!", text: "Error: No keyword.")
            return
        }
        
        let vigenere = VigenereAlg(key: keyword)
        cipherText = vigenere.encrypt(messageText: messageText)
        encryptedMessageField.stringValue = cipherText
    }
    
    @IBAction func decodeBtn(_ sender: Any) {
        cipherText = (encryptedMessageField.stringValue.uppercased()).filter { return russianAlphabet.contains($0) }
        if cipherText == "" {
            dialogError(question: "Your encrypted message is an empty!", text: "Error: Nothing to decode.")
            return
        }
        
        let filteredKeyword = keyword.filter { return russianAlphabet.contains($0) }
        keyword = String(filteredKeyword)
        
        keyword = keywordField.stringValue
        keywordField.stringValue = keyword
        if keyword == "" {
            dialogError(question: "Please, specify the keyword!", text: "Error: No keyword.")
            return
        }
        
        let vigenere = VigenereAlg(key: keyword)
        messageText = vigenere.decrypt(encryptedText: cipherText)
        
        originalMessageField.stringValue = messageText
    }
    
    @IBAction func saveBtn(_ sender: NSButton) {
        let fileURL = URL(fileURLWithPath: browseFile(sender: self))
        if fileURL == fileURLZ {
        } else {
            switch sender.tag {
            case 0:
                do {
                    try originalMessageField.stringValue.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                    dialogError(question: "Failed writing to URL \(fileURL)", text: "Error: " + error.localizedDescription)
                }
            case 1:
                do {
                    try encryptedMessageField.stringValue.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                    dialogError(question: "Failed writing to URL \(fileURL)", text: "Error: " + error.localizedDescription)
                }
            default:
                break
            }
        }
    }
    
    
    @IBAction func loadBtn(_ sender: NSButton) {
        let fileURL = URL(fileURLWithPath: browseFile(sender: self))
        if fileURL == fileURLZ {
        } else {
            switch sender.tag {
            case 0:
                do {
                    originalMessageField.stringValue  = try String(contentsOf: fileURL)
                } catch {
                    dialogError(question: "Failed reading from URL: \(fileURL)", text: "Error: " + error.localizedDescription)
                }
            case 1:
                do {
                    encryptedMessageField.stringValue = try String(contentsOf: fileURL)
                } catch {
                    dialogError(question: "Failed reading from URL: \(fileURL)", text: "Error: " + error.localizedDescription)
                }
            default:
                break
            }
        }
    }
}
