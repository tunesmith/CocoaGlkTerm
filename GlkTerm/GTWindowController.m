//
//  GTWindowController.m
//  GlkTerm
//
//  Created by Andrew Hunter on 02/06/2007.
//  Copyright 2007 Andrew Hunter. All rights reserved.
//

#import "GTWindowController.h"

@implementation GTWindowController

// = Initialisation =

- (id) init {
	self = [super initWithWindowNibName: @"GlkWindow"
								  owner: self];
	
	if (self) {
		prefs = [[GlkPreferences alloc] init];
	}
	
	return self;
}

- (void) dealloc {
	[glkView release];
	[super dealloc];
}

- (void) windowDidLoad {
	[logDrawer setLeadingOffset: 16];
	[logDrawer setContentSize: NSMakeSize([logDrawer contentSize].width, 120)];
	[logDrawer setMinContentSize: NSMakeSize(0, 120)];

	[super windowDidLoad];
}

// = KVC type stuff =

- (void) setGlkView: (GlkView*) newGlkView {
	// Remember this glk view
	[glkView release];
	glkView = [newGlkView retain];

	// Set the preferences for the view
	[glkView setPreferences: prefs];
	[glkView setBorderWidth: 0];
}

- (GlkView*) glkView {
	return glkView;
}

// = NSWindow delegate =

- (void)windowWillClose:(NSNotification *)aNotification {
	[[NSApp delegate] finishedWithWindow: self];
}

// = GlkView delegate =

- (void) showLogMessage: (NSString*) message
			 withStatus: (GlkLogStatus) status {
	// Choose a style for this message
	float msgSize = 10;
	NSColor* msgColour = [NSColor grayColor];
	BOOL isBold = NO;
	
	switch (status) {
		case GlkLogRoutine:
			break;
			
		case GlkLogInformation:
			isBold = YES;
			break;
			
		case GlkLogCustom:
			msgSize = 12;
			msgColour = [NSColor blackColor];
			break;
			
		case GlkLogWarning:
			msgColour = [NSColor blueColor];
			msgSize = 12;
			break;
			
		case GlkLogError:
			msgSize = 12;
			msgColour = [NSColor redColor];
			isBold = YES;
			break;
			
		case GlkLogFatalError:
			msgSize = 12;
			msgColour = [NSColor colorWithDeviceRed: 0.8
											  green: 0
											   blue: 0
											  alpha: 1.0];
			isBold = YES;
			break;
	}
	
	// Create the attributes for this style
	NSFont* font;
	
	if (isBold) {
		font = [NSFont boldSystemFontOfSize: msgSize];
	} else {
		font = [NSFont systemFontOfSize: msgSize];
	}
	
	NSDictionary* msgAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
		font, NSFontAttributeName,
		msgColour, NSForegroundColorAttributeName,
		nil];
	
	// Create the attributed string
	NSAttributedString* newMsg = [[NSAttributedString alloc] initWithString: [message stringByAppendingString: @"\n"]
																 attributes: msgAttributes];
	
	// Append this message to the log
	[[logView textStorage] appendAttributedString: [newMsg autorelease]];
	[logView scrollRangeToVisible: NSMakeRange([[logView textStorage] length]-1, 1)];
	
	// Show the log drawer
	if (status >= GlkLogWarning) {
		[logDrawer open: self];
	}	
}

// = General actions =

- (IBAction) showLogWindow: (id) sender {
	[logDrawer open: self];
}

@end
