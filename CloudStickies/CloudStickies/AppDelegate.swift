//
//  AppDelegate.swift
//  CloudStickies
//
//  Created by Thiago on 08/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa
import RealmSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //MARK: Properties
    
    var stickyControllers: [StickyWindowController] = []
    
    var statusItem: NSStatusItem?
    
    //MARK: Callbacks
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        setupMenuBarIcon()
        
        setupButtonMenu()
        
        openSavedNotes()
        
        print(Realm.Configuration.defaultConfiguration.path!)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
    }
    
    //MARK: Setup
    
    private func setupMenuBarIcon() {
        
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)

        statusItem?.image = NSImage(named: "MenuBarIcon")
    }
    
    private func setupButtonMenu() {
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Nova Nota", action: "newNote", keyEquivalent: "n"))
        
        menu.addItem(NSMenuItem.separatorItem())
        
        menu.addItem(NSMenuItem(title: "Sair", action: "terminate:", keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
    
    private func openSavedNotes() {
        
        for note in StickyNote.all() {
            
            if let controller = StickyWindowController.note(self.stickyControllers.last, id: note.id) {
                
                self.stickyControllers.append(controller)
                
                controller.showWindow(self)
            }
        }
    }
    
    //MARK: Actions
    
    func newNote() {
        
        if let controller = StickyWindowController.note(self.stickyControllers.last) {
        
            self.stickyControllers.append(controller)
        
            controller.showWindow(self)
        }
    }

    @IBAction func closeWindowPressed(sender: AnyObject) {
        
        var controllerToBetTerminated: StickyWindowController?
        
        for controller in self.stickyControllers {
            
            if let window = controller.window {
                
                if window.mainWindow {
                    
                    controllerToBetTerminated = controller
                }
            }
        }

        controllerToBetTerminated?.close()
    }
}

