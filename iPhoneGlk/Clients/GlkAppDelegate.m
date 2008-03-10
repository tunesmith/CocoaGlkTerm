//
//  GlkAppDelegate.m
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import "GlkAppDelegate.h"


@implementation GlkAppDelegate

@synthesize window;
@synthesize content;
@synthesize session;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	// Initialise the session
	session = [[GlkSession alloc] init];
	
	// Create window
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Set up content view
	self.content = [[[GlkViewController alloc] init] autorelease];
	[window addSubview: self.content.view];

	// Start the session running
	self.session.bufferTarget = self.content;
	[self.session startInterpreter];

	// Show window
	[window makeKeyAndVisible];
}

- (void)dealloc {
	[session release];
	[content release];
	[window release];
	[super dealloc];
}

@end
