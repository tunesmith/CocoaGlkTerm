//
//  GlkViewController.m
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import "GlkViewController.h"


@implementation GlkViewController

// = Initialisation =

- (id)init
{
	if (self = [super init]) {
		// Initialize your view controller.
		self.title = @"GlkViewController";
	}
	return self;
}

- (void)dealloc
{
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

// = GlkBuffer implementation =

// Windows

// Creating the various types of window

- (void) createBlankWindowWithIdentifier: (glui32) identifier {
	NSLog(@"Implement me!");
}

- (void) createTextGridWindowWithIdentifier: (glui32) identifier {
	NSLog(@"Implement me!");
}

- (void) createTextWindowWithIdentifier: (glui32) identifer {
	NSLog(@"Implement me!");
}

- (void) createGraphicsWindowWithIdentifier: (glui32) identifier {
	NSLog(@"Implement me!");
}

// Placing windows in the tree

- (void) setRootWindow: (glui32) identifier {
	NSLog(@"Implement me!");
}

- (void) createPairWindowWithIdentifier: (glui32) identifier
							  keyWindow: (glui32) keyIdentifier
							 leftWindow: (glui32) leftIdentifier
							rightWindow: (glui32) rightIdentifier
								 method: (glui32) method
								   size: (glui32) size {
	NSLog(@"Implement me!");
}

// Closing windows

- (void) closeWindowIdentifier: (glui32) identifier {
	NSLog(@"Implement me!");
}

// Manipulating windows

- (void) moveCursorInWindow: (glui32) identifier
				toXposition: (int) xpos
				  yPosition: (int) ypos {
	NSLog(@"Implement me!");
}

- (void) clearWindowIdentifier: (glui32) identifier {
	NSLog(@"Implement me!");
}

- (void) setInputLine: (in bycopy NSString*) inputLine
  forWindowIdentifier: (unsigned) windowIdentifier {
	NSLog(@"Implement me!");
}

- (void) arrangeWindow: (glui32) identifier
				method: (glui32) method
				  size: (glui32) size
			 keyWindow: (glui32) keyIdentifier {
	NSLog(@"Implement me!");
}

// Styles

- (void) setStyleHint: (glui32) hint
			 forStyle: (glui32) style
			  toValue: (glsi32) value
		   windowType: (glui32) wintype {
	NSLog(@"Implement me!");
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
	NSLog(@"Implement me!");
}

- (void) registerStreamForWindow: (unsigned) windowIdentifier
				   forIdentifier: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

- (void) closeStreamIdentifier: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

- (void) unregisterStreamIdentifier: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

// Buffering stream writes

- (void) putChar: (unichar) ch
		toStream: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

- (void) putString: (in bycopy NSString*) string
		  toStream: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

- (void) putData: (in bycopy NSData*) data							// Note: do not pass in mutable data here, as the contents may change unexpectedly
		toStream: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
}

- (void) setStyle: (unsigned) style
		 onStream: (unsigned) streamIdentifier {
	NSLog(@"Implement me!");
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

@end
