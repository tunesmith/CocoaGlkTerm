//
//  GTAppDelegate.h
//  GlkTerm
//
//  Created by Andrew Hunter on 02/06/2007.
//  Copyright 2007 Andrew Hunter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//
// Application delegate
//
@interface GTAppDelegate : NSObject {
	IBOutlet NSWindow* introWindow;						// The initial 'do this' window
	
	NSMutableArray* windowControllers;					// The list of window controllers associated with this delegate
}

- (void) finishedWithWindow: (NSWindowController*) oldControl;	// Called when a window controller's window is closed

@end
