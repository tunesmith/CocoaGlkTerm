//
//  GTAppDelegate.m
//  GlkTerm
//
//  Created by Andrew Hunter on 02/06/2007.
//  Copyright 2007 Andrew Hunter. All rights reserved.
//

#import "GTAppDelegate.h"
#import "GTWindowController.h"

#import <GlkView/GlkHub.h>

@implementation GTAppDelegate

- (id) init {
	self = [super init];
	
	if (self) {
		windowControllers = [[NSMutableArray alloc] init];
	}
	
	return self;
}

// = Application delegate =

- (void)applicationWillFinishLaunching: (NSNotification*) aNotification {
	// Set up a general hub
	[[GlkHub sharedGlkHub] setHubName: @"CocoaGlk"];
	[[GlkHub sharedGlkHub] setDelegate: self];
}

// = GlkHub delegate =

- (NSObject<GlkSession>*) createAnonymousSession {
	GTWindowController* controller = [[GTWindowController alloc] init];
	
	[introWindow orderOut: self];
	[controller showWindow: self];
	
	[windowControllers addObject: [controller autorelease]];
	
	return [controller glkView];
}

- (void) finishedWithWindow: (NSWindowController*) oldControl {
	// Ensure the controller isn't released too early
	[[oldControl retain] autorelease];
	
	// Remove from the list of window controllers we're managing
	[windowControllers removeObjectIdenticalTo: oldControl];
	
	if ([windowControllers count] == 0) {
		[introWindow orderFront: self];
	}
}

@end
