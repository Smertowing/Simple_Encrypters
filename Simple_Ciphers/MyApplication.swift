//
//  MyApplication.swift
//  Simple_Ciphers
//
//  Created by Kiryl Holubeu on 9/10/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation
import Cocoa

class MyApplication: NSApplication {
    override func sendEvent(_ event: NSEvent) {
        if event.type == NSEvent.EventType.keyDown {
            
            if (event.modifierFlags.contains(NSEvent.ModifierFlags.command)) {
                switch event.charactersIgnoringModifiers!.lowercased() {
                case "x":
                    if NSApp.sendAction(#selector(NSText.cut(_:)), to:nil, from:self) { return }
                case "c":
                    if NSApp.sendAction(#selector(NSText.copy(_:)), to:nil, from:self) { return }
                case "v":
                    if NSApp.sendAction(#selector(NSText.paste(_:)), to:nil, from:self) { return }
                case "a":
                    if NSApp.sendAction(#selector(NSText.selectAll(_:)), to:nil, from:self) { return }
                default:
                    break
                }
            }
        }
        return super.sendEvent(event)
    }
    
}

