//
//  GTWindowController.h
//  GlkTerm
//
//  Created by Andrew Hunter on 02/06/2007.
//  Copyright 2007 Andrew Hunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <GlkView/GlkView.h>

#import "GTAppDelegate.h"

//
// Window controller for managine a Glk session
//
@interface GTWindowController : NSWindowController {
	IBOutlet GlkView* glkView;							// The GlkView object
	
	IBOutlet NSDrawer* logDrawer;						// The drawer containing the CocoaGlk log
	IBOutlet NSTextView* logView;						// The text view that log messages are sent to
	
	GlkPreferences* prefs;								// The preferences for this controller
}

// = KVC stuff =

- (void) setGlkView: (GlkView*) glkView;
- (GlkView*) glkView;

// = General actions =

- (IBAction) showLogWindow: (id) sender;

@end
