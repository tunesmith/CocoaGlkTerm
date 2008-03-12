//
//  GlkViewController.m
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import "GlkViewController.h"

#import "GlkTextWindow.h"

@implementation GlkViewController

// = Initialisation =

- (id)init
{
	if (self = [super init]) {
		// Set the controller title
		self.title = @"GlkViewController";
		
		// Create the window dictionary
		glkWindows = [[NSMutableDictionary alloc] init];
		glkStreams = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[root release];
	[lastRoot release];
	[glkWindows release];
	[glkStreams release];
	
	[super dealloc];
}

- (void)loadView
{
	// Allocate the initial view.
	UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	self.view = view;
	[view release];
}

// = UIViewController overrides =

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// We can run in portrait or landscape mode
	return (interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview.
	// Release anything that's not essential, such as cached data.
}

// = GlkBufferTarget implementation =

- (void) layoutWindows {
	[lastRoot removeFromSuperview];
	[self.view addSubview: root];
	[self.view setNeedsDisplay];	
}

- (void) updateRootWindow {
	[root layoutInRect: [self.view bounds]];
}

// = GlkBuffer implementation =

// Windows

// Creating the various types of window

- (void) createBlankWindowWithIdentifier: (glui32) identifier {
	GlkWindow* newWindow = [[GlkWindow alloc] init];
	
	newWindow.windowIdentifier = identifier;
	// [newWindow setEventTarget: self];
	// [newWindow setContainingView: self];
	
	[glkWindows setObject: [newWindow autorelease]
				   forKey: [NSNumber numberWithUnsignedInt: identifier]];
}

- (void) createTextGridWindowWithIdentifier: (glui32) identifier {
	NSLog(@"Implement me: create text grid windows");
	
	GlkWindow* newWindow = [[GlkWindow alloc] init];
	
	newWindow.windowIdentifier = identifier;
	// [newWindow setEventTarget: self];
	// [newWindow setContainingView: self];
	
	[glkWindows setObject: [newWindow autorelease]
				   forKey: [NSNumber numberWithUnsignedInt: identifier]];
}

- (void) createTextWindowWithIdentifier: (glui32) identifier {
	GlkWindow* newWindow = [[GlkTextWindow alloc] init];
	
	newWindow.windowIdentifier = identifier;
	// [newWindow setEventTarget: self];
	// [newWindow setContainingView: self];
	
	[glkWindows setObject: [newWindow autorelease]
				   forKey: [NSNumber numberWithUnsignedInt: identifier]];
}

- (void) createGraphicsWindowWithIdentifier: (glui32) identifier {
	NSLog(@"Implement me: create graphics windows");

	GlkWindow* newWindow = [[GlkWindow alloc] init];
	
	newWindow.windowIdentifier = identifier;
	// [newWindow setEventTarget: self];
	// [newWindow setContainingView: self];
	
	[glkWindows setObject: [newWindow autorelease]
				   forKey: [NSNumber numberWithUnsignedInt: identifier]];
}

// Placing windows in the tree

- (void) setRootWindow: (glui32) identifier {
	if (identifier == GlkNoWindow) {
		[root release];
		root = nil;
		
		windowsNeedLayout = YES;
		return;
	}
	
	GlkWindow* newRootWindow = [glkWindows objectForKey: [NSNumber numberWithUnsignedInt: identifier]];
	if (newRootWindow) {
		[root release];
		root = [newRootWindow retain];
		
		windowsNeedLayout = YES;
	} else {
		NSLog(@"Warning: attempt to set the root window to a nonexistent window");
	}
}

- (void) createPairWindowWithIdentifier: (glui32) identifier
							  keyWindow: (glui32) keyId
							 leftWindow: (glui32) leftId
							rightWindow: (glui32) rightId
								 method: (glui32) method
								   size: (glui32) size {
	GlkWindow* key = [glkWindows objectForKey: [NSNumber numberWithUnsignedInt: keyId]];
	GlkWindow* left = [glkWindows objectForKey: [NSNumber numberWithUnsignedInt: leftId]];
	GlkWindow* right = [glkWindows objectForKey: [NSNumber numberWithUnsignedInt: rightId]];
	
	// Sanity check
	if (key == nil || left == nil || right == nil) {
		NSLog(@"Warning: attempt to create pair window with nonexistent child windows");
		return;
	}
	
	if (right.parentWindow != nil) {
		NSLog(@"Warning: rightmost window of a pair must not already be in the tree (odd behaviour will result)");
	}
	
	// Create the pair window
	GlkPairWindow* newWin = [[GlkPairWindow alloc] init];
	glui32 winDir = method & winmethod_DirMask;
	
	newWin.fixed			= (method&winmethod_Fixed)!=0;
	newWin.size				= size;
	newWin.above			= winDir==winmethod_Above||winDir==winmethod_Left;
	newWin.horizontal		= winDir==winmethod_Left||winDir==winmethod_Right;
	newWin.windowIdentifier	= identifier;
	// [newWin setEventTarget: self];
	// [newWin setPreferences: prefs];
	// [newWin setContainingView: self];
	
	// Change the structure if the left window is not topmost
	if (left.parentWindow) {
		if (left.parentWindow.leftWindow == left) {
			left.parentWindow.leftWindow = newWin;
		} else if (left.parentWindow.rightWindow == left) {
			left.parentWindow.rightWindow = newWin;
		} else {
			NSLog(@"Warning: parent windows do not match up (odd behaviour will result)");
		}
	}
	
	// Set the structure of the new window
	newWin.keyWindow	= key;
	newWin.leftWindow	= left;
	newWin.rightWindow	= right;
	
	right.parentWindow	= newWin;
	left.parentWindow	= newWin;
	
	// Add to the window structure
	[glkWindows setObject: [newWin autorelease]
				   forKey: [NSNumber numberWithUnsignedInt: identifier]];
	windowsNeedLayout = YES;
}

// Closing windows

- (void) removeIdentifier: (glui32) identifier {
	GlkPairWindow* win = [[glkWindows objectForKey: [NSNumber numberWithUnsignedInt: identifier]] retain];
	
	if ([win isKindOfClass: [GlkPairWindow class]]) {
		// Remove the ID for the left and right windows
		if ([win leftWindow]) [self removeIdentifier: [[win leftWindow] windowIdentifier]];
		if ([win rightWindow]) [self removeIdentifier: [[win rightWindow] windowIdentifier]];
	}
	
	// Remove from the list of known windows
	[glkWindows removeObjectForKey: [NSNumber numberWithUnsignedInt: identifier]];
	
	// Remove from the superview
	[win removeFromSuperview];
	
	// Remove from existence (usually)
	[win release];
	
	windowsNeedLayout = YES;
}

- (void) closeWindowIdentifier: (glui32) identifier {
	GlkWindow* win = [glkWindows objectForKey: [NSNumber numberWithUnsignedInt: identifier]];
	
	if (!win) {
		NSLog(@"Warning: attempt to close a nonexistent window");
		return;
	}
	
	// Deal with the parent window
	GlkPairWindow* parent = win.parentWindow;
	
	if (parent) {
		GlkPairWindow* grandparent = parent.parentWindow;
		GlkWindow* sibling = nil;
		
		// Find our sibling
		if ([parent leftWindow] == win) {
			sibling = [[[parent rightWindow] retain] autorelease];
			[parent setRightWindow: nil];
		} else if ([parent rightWindow] == win) {
			sibling = [[[parent leftWindow] retain] autorelease];
			[parent setLeftWindow: nil];
		} else {
			NSLog(@"Oops, failed to find a sibling window");
		}
		
		parent.parentWindow = nil;
		
		if (grandparent) {
			// Replace the appropriate window in the grandparent
			sibling.parentWindow = grandparent;
			
			if ([grandparent leftWindow] == parent) {
				[grandparent setLeftWindow: sibling];
			} else if ([grandparent rightWindow] == parent) {
				[grandparent setRightWindow: sibling];
			} else {
				NSLog(@"Oops, failed to find the parent window in the grandparent");
			}
		} else {
			// Replace the root window
			[root release];
			root = [sibling retain];
		}
		
		// Mark the parent as closed
		[parent setClosed: YES];
		
		// Remove the parent window identifier
		[self removeIdentifier: parent.windowIdentifier];
	} else {
		// We've closed the root window
		[root release];
		root = nil;
		
		// Mark this window as closed
		[win setClosed: YES];
		
		// Remove this window identifier
		[self removeIdentifier: identifier];
	}
	
	// We'll need to layout the windows again
	windowsNeedLayout = YES;
}

// Manipulating windows

- (void) moveCursorInWindow: (glui32) identifier
				toXposition: (int) xpos
				  yPosition: (int) ypos {
	NSLog(@"Implement me: move cursor");
}

- (void) clearWindowIdentifier: (glui32) identifier {
	NSLog(@"Implement me: clear window");
}

- (void) setInputLine: (in bycopy NSString*) inputLine
  forWindowIdentifier: (unsigned) windowIdentifier {
	NSLog(@"Implement me: set input line");
}

- (void) arrangeWindow: (glui32) identifier
				method: (glui32) method
				  size: (glui32) size
			 keyWindow: (glui32) keyIdentifier {
	NSLog(@"Implement me: arrange window");
}

// Styles

- (void) setStyleHint: (glui32) hint
			 forStyle: (glui32) style
			  toValue: (glsi32) value
		   windowType: (glui32) wintype {
	NSLog(@"Implement me: set style hint");
}

- (void) clearStyleHint: (glui32) hint
			   forStyle: (glui32) style
			 windowType: (glui32) wintype {
	NSLog(@"Implement me!");
}

- (void) setStyleHint: (glui32) hint
			  toValue: (glsi32) value
			 inStream: (glui32) streamIdentifier  {
	NSLog(@"Implement me!");
}
	
- (void) clearStyleHint: (glui32) hint
			   inStream: (glui32) streamIdentifier {
	NSLog(@"Implement me!");
}

- (void) setCustomAttributes: (NSDictionary*) attributes
					inStream: (glui32) streamIdentifier {
	NSLog(@"Implement me!");
}

// Graphics

- (void) fillAreaInWindowWithIdentifier: (unsigned) identifier
							 withColour: (in bycopy UIColor*) color
							  rectangle: (NSRect) windowArea {
	NSLog(@"Implement me!");
}

- (void) drawImageWithIdentifier: (unsigned) imageIdentifier
		  inWindowWithIdentifier: (unsigned) windowIdentifier
					  atPosition: (NSPoint) position {
	NSLog(@"Implement me!");
}

- (void) drawImageWithIdentifier: (unsigned) imageIdentifier
		  inWindowWithIdentifier: (unsigned) windowIdentifier
						  inRect: (NSRect) imageRect {
	NSLog(@"Implement me!");
}

- (void) drawImageWithIdentifier: (unsigned) imageIdentifier
		  inWindowWithIdentifier: (unsigned) windowIdentifier
					   alignment: (unsigned) alignment {
	NSLog(@"Implement me!");
}

- (void) drawImageWithIdentifier: (unsigned) imageIdentifier
		  inWindowWithIdentifier: (unsigned) windowIdentifier
					   alignment: (unsigned) alignment
							size: (NSSize) imageSize {
	NSLog(@"Implement me!");
}

- (void) breakFlowInWindowWithIdentifier: (unsigned) identifier {
	NSLog(@"Implement me!");
}

// Streams

// Registering streams

- (void) registerStream: (in byref NSObject<GlkStream>*) stream
		  forIdentifier: (unsigned) streamIdentifier {
	[glkStreams setObject: stream
				   forKey: [NSNumber numberWithUnsignedInt: streamIdentifier]];
}

- (void) registerStreamForWindow: (unsigned) windowIdentifier
				   forIdentifier: (unsigned) streamIdentifier {
	[glkStreams setObject: [glkWindows objectForKey: [NSNumber numberWithUnsignedInt: windowIdentifier]]
				   forKey: [NSNumber numberWithUnsignedInt: streamIdentifier]];
}

- (void) closeStreamIdentifier: (unsigned) streamIdentifier {
	[(NSObject<GlkStream>*)[glkStreams objectForKey: [NSNumber numberWithUnsignedInt: streamIdentifier]] closeStream];
}

- (void) unregisterStreamIdentifier: (unsigned) streamIdentifier {
	[glkStreams removeObjectForKey: [NSNumber numberWithUnsignedInt: streamIdentifier]];
}

// Buffering stream writes

- (void) putChar: (unichar) ch
		toStream: (unsigned) streamIdentifier {
	[(NSObject<GlkStream>*)[glkStreams objectForKey: [NSNumber numberWithUnsignedInt: streamIdentifier]] 
				putChar: ch];
}

- (void) putString: (in bycopy NSString*) string
		  toStream: (unsigned) streamIdentifier {
	[(NSObject<GlkStream>*)[glkStreams objectForKey: [NSNumber numberWithUnsignedInt: streamIdentifier]] 
				putString: string];
}

- (void) putData: (in bycopy NSData*) data							// Note: do not pass in mutable data here, as the contents may change unexpectedly
		toStream: (unsigned) streamIdentifier {
	[(NSObject<GlkStream>*)[glkStreams objectForKey: [NSNumber numberWithUnsignedInt: streamIdentifier]] 
				putBuffer: data];
}

- (void) setStyle: (unsigned) style
		 onStream: (unsigned) streamIdentifier {
	[(NSObject<GlkStream>*)[glkStreams objectForKey: [NSNumber numberWithUnsignedInt: streamIdentifier]] 
				setStyle: style];
}

// Hyperlinks on streams

- (void) setHyperlink: (unsigned int) value
			 onStream: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

- (void) clearHyperlinkOnStream: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

// Events

// Requesting events

- (void) requestLineEventsForWindowIdentifier:      (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

- (void) requestCharEventsForWindowIdentifier:      (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

- (void) requestMouseEventsForWindowIdentifier:     (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

- (void) requestHyperlinkEventsForWindowIdentifier: (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

- (void) cancelCharEventsForWindowIdentifier:      (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

- (void) cancelMouseEventsForWindowIdentifier:     (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

- (void) cancelHyperlinkEventsForWindowIdentifier: (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

// = GlkBufferTarget implementation =

- (GlkWindow*) windowWithIdentifier: (int) windowId {
	// Retrieves the window with the specified identifier
	return [glkWindows objectForKey: [NSNumber numberWithInt: windowId]];
}

@synthesize root;
@synthesize lastRoot;
@synthesize windowsNeedLayout;
@end
