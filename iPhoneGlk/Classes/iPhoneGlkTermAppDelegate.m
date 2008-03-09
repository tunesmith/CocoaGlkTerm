//
//  iPhoneGlkTermAppDelegate.m
//  iPhoneGlkTerm
//
//  Created by Andrew Hunter on 09/03/2008.
//  Copyright Andrew Hunter 2008. All rights reserved.
//

#import "iPhoneGlkTermAppDelegate.h"
#import "MyView.h"

@implementation iPhoneGlkTermAppDelegate

@synthesize window;
@synthesize contentView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	// Create window
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Set up content view
	self.contentView = [[[MyView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
	[window addSubview:contentView];
    
	// Show window
	[window makeKeyAndVisible];
}

- (void)dealloc {
	[contentView release];
	[window release];
	[super dealloc];
}

@end
