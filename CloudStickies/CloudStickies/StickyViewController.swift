//
//  StickyViewController.swift
//  CloudStickies
//
//  Created by Thiago on 08/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa
import RealmSwift

class StickyViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textView: StickyTextView!
    
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint!
    
    //MARK: Properties
    
    private var initialPosition = NSPoint()
    private var editable = true
    private var savingTimer: NSTimer?
    
    var noteID: Int?
    var note: StickyNote?
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        separatorHeightConstraint.constant = 1.0 / (NSScreen.mainScreen()?.backingScaleFactor)!
        
        self.textView.delegate = self
    }
    
    //MARK: Setup
    
    func setupNote() {
        
        if let id = self.noteID {
            
            self.note = StickyNote.byId(id)
            
            self.textView?.string = self.note?.content
            
        } else {
            
            self.note = StickyNote()
            
            if let lastID = StickyNote.all().sorted("id", ascending: false).first?.id {
                
                self.note?.id = lastID + 1
                
            } else {
                
                self.note?.id = 1
            }
            
            self.noteID = self.note?.id
            
            StickyNote.save(self.note!)
        }
    }
    
    //MARK: TextView events
    
    func textDidChange(notification: NSNotification) {
        
        self.savingTimer?.invalidate()
        
        if let text = self.textView.textStorage?.string {
            
            savingTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "saveNoteToDatabase:", userInfo: ["content":text], repeats: false)
        }
    }
    
    //MARK: Timers
    
    func saveNoteToDatabase(timer: NSTimer) {
        
        let text = timer.userInfo?["content"] as? String ?? ""
        
        let realm = try! Realm()
        
        try! realm.write { () -> Void in
            
            self.note?.content = text
        }
    }
    
    //MARK: Actions
    
    @IBAction func disableWindowEditing(sender: NSButton) {
        self.editable = sender.state == NSOffState
    }
    
    //MARK: Drag events
    
    override func mouseDown(theEvent: NSEvent) {
        
        guard editable else {
            return
        }
        
        let windowFrame = self.view.window?.frame
        initialPosition = NSEvent.mouseLocation()
        initialPosition.x -= windowFrame!.origin.x
        initialPosition.y -= windowFrame!.origin.y
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        
        guard editable else {
            return
        }
        
        guard initialPosition.y >= 0 else {
            return
        }
        
        var currentPosition = NSPoint()
        var newOrigin = NSPoint()
        
        let screenFrame = NSScreen.mainScreen()?.frame
        let windowFrame = self.view.frame
        
        currentPosition = NSEvent.mouseLocation()
        newOrigin.x = currentPosition.x - initialPosition.x
        newOrigin.y = currentPosition.y - initialPosition.y
        
        if (newOrigin.y + windowFrame.height) > ((screenFrame?.origin.y)! + (screenFrame?.height)!) {
            newOrigin.y = (screenFrame?.origin.y)! + (screenFrame?.height)! - windowFrame.height
        }
        
        self.view.window?.setFrameOrigin(newOrigin)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        guard editable else {
            return
        }
        
        initialPosition.y = -1
    }
    
}

