//
//  GlkSession.m
//  iPhoneGlk
//
//  Created by Andrew Hunter on 09/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import "GlkSession.h"

#import <GlkClient/glk_client.h>

@implementation GlkSession

// = Initialisation =

- (id) init {
	self = [super init];
	
	if (self) {
	}
	
	return self;
}

- (void) dealloc {
	// Free up the thread connections
	[mainThreadPort release];
	[terpThreadPort release];
	[mainThread release];
	[terpThread release];
	
	[bufferTarget release];
	
	[super dealloc];
}

// = The interpreter thread =

- (void) startInterpreter {
	// Launches the interpreter thread
	
	// Do nothing if a session is already running
	if (cocoaglk_session) return;
	
	// Set up the ports
	mainThreadPort = [[NSPort port] retain];
	terpThreadPort = [[NSPort port] retain];

	[[NSRunLoop currentRunLoop] addPort: mainThreadPort
								forMode: NSDefaultRunLoopMode];

	// Set up the main thread connection
	mainThread = [[NSConnection alloc] initWithReceivePort: mainThreadPort
												  sendPort: terpThreadPort];
	[mainThread setRootObject: self];
	
	// Run the interpreter thread
	[self retain];
	[NSThread detachNewThreadSelector: @selector(interpreterThread:)
							 toTarget: self
						   withObject: nil];
}

- (void) interpreterThread: (id) obj {
	// Create the initial interpreter autorelease pool
	cocoaglk_pool = [[NSAutoreleasePool alloc] init];
	
	// Connect to the main thread
	[[NSRunLoop currentRunLoop] addPort: terpThreadPort
								forMode: NSDefaultRunLoopMode];
	terpThread = [[NSConnection alloc] initWithReceivePort: terpThreadPort
												  sendPort: mainThreadPort];
	
	// Set the session object
	[[terpThread rootProxy] setProtocolForProxy: @protocol(GlkSession)];
	cocoaglk_session = (GlkSession*)[terpThread rootProxy];
	
	// Set up the initial buffer
	cocoaglk_buffer = [[GlkBuffer alloc] init];
	
	// Signal that the interpreter is starting (an opportunity to set things up outside glk_main)
	[self interpreterStarting: self];
	
	// Start the main interpreter loop
	glk_main();
	
	// Release when the thread finishes
	[cocoaglk_pool release];
	cocoaglk_pool = nil;
	[self release];
}

- (void) interpreterStarting: (GlkSession*) session {
	if (delegate && [delegate respondsToSelector: @selector(interpreterStarting)]) {
		[delegate interpreterStarting: session];
	}
}

// = The Glk session implementation =

// = Housekeeping =

- (void) clientHasStarted: (pid_t) processId {
	// Not used in iPhone glk
}

- (void) clientHasFinished {
	// Not used in iPhone glk
}

// = Receiving data from the buffer =

- (void) performOperationsFromBuffer: (in bycopy GlkBuffer*) buffer {
	if (!bufferTarget) return;
	
	if (flushing) {
		NSLog(@"WARNING: buffer flush deferred to avoid out-of-order data");
		
		[[NSRunLoop currentRunLoop] performSelector: @selector(performOperationsFromBuffer:)
											 target: self
										   argument: buffer
											  order: 64
											  modes: [NSArray arrayWithObject: NSDefaultRunLoopMode]];
		return;
	}
		
	flushing = YES;
	
	// Remember the current root window
	bufferTarget.lastRoot	= bufferTarget.root;
	
	// Signal that the buffer is flushing
	[bufferTarget.root bufferIsFlushing];
	
	// *WOOOSSSSHH*
	[buffer flushToTarget: bufferTarget];
	
	// Tell the buffer target to change its window layout if necessary
	if (bufferTarget.windowsNeedLayout && bufferTarget.root != nil) {
		if (bufferTarget.lastRoot != bufferTarget.root) {
			[bufferTarget updateRootWindow];
		}
		
		[bufferTarget layoutWindows];
		bufferTarget.windowsNeedLayout = NO;
	}
	
	[bufferTarget.root bufferHasFlushed];
	bufferTarget.lastRoot = nil;
	
	flushing = NO;
}

// = Windows =

- (GlkSize) sizeForWindowIdentifier: (unsigned) windowId {
	// TODO
	NSLog(@"IMPLEMENT ME");

	GlkSize result;
	result.width = result.height = 0;
	return result;
}

// = Streams =

- (byref NSObject<GlkStream>*) streamForWindowIdentifier: (unsigned) windowId {
	return [bufferTarget windowWithIdentifier: windowId];
}

- (byref NSObject<GlkStream>*) inputStream {
	// TODO
	NSLog(@"IMPLEMENT ME");

	return nil;
}

- (byref NSObject<GlkStream>*) streamForKey: (in bycopy NSString*) key {
	// TODO
	NSLog(@"IMPLEMENT ME");

	return nil;
}

// = Styles =

- (glui32) measureStyle: (glui32) styl
				   hint: (glui32) hint
			   inWindow: (glui32) windowId {
	// TODO
	NSLog(@"IMPLEMENT ME");

	return 0;
}

// Events
- (bycopy NSString*) cancelLineEventsForWindowIdentifier: (unsigned) windowIdentifier {
	// TODO
	NSLog(@"IMPLEMENT ME");

	return nil;
}

- (bycopy NSObject<GlkEvent>*) nextEvent {
	// TODO
	NSLog(@"IMPLEMENT ME");

	return nil;
}

- (void) setEventListener: (in byref NSObject<GlkEventListener>*) listener {
	// TODO
	NSLog(@"IMPLEMENT ME");
}

- (void) willSelect {
	// TODO
	NSLog(@"IMPLEMENT ME");
}

- (int)  synchronisationCount {
	// Gets the sync count value (this is used to determine if information cached on the server is still relevant)
	NSLog(@"IMPLEMENT ME");

	return 0;
}

// Errors and warnings
- (void) showError: (in bycopy NSString*) error {
	// Shows an error message
	UIAlertView* dohTheHumanity = [[UIAlertView alloc] initWithTitle: @"Glk Error"
															 message: error
															delegate: self
												   cancelButtonTitle: @"Cancel"
												   otherButtonTitles: nil];
	[dohTheHumanity show];
	
	NSLog(@"IMPLEMENT ME");
}

- (void) showWarning: (in bycopy NSString*) warning {
	// Shows a warning message
	NSLog(@"IMPLEMENT ME");
}

- (void) logMessage: (in bycopy NSString*) message {
	// Shows a log message
	NSLog(@"IMPLEMENT ME");
}

- (void) logMessage: (in bycopy NSString*) message
	   withPriority: (int) priority {
	// Shows a log message with a priority
	NSLog(@"IMPLEMENT ME");
}

// Filerefs
- (NSObject<GlkFileRef>*) fileRefWithName: (in bycopy NSString*) name{
	// Returns NULL if the name is invalid (or if we're not supporting named files for some reason)
	// TODO
	NSLog(@"IMPLEMENT ME");
	return nil;
}

- (NSObject<GlkFileRef>*) tempFileRef {
	// Temp files are automagically deleted when the session goes away
	// TODO
	NSLog(@"IMPLEMENT ME");
	return nil;
}

- (bycopy NSArray*) fileTypesForUsage: (in bycopy NSString*) usage {
	// Returns the list of the preferred filetypes for the specified usage
	// TODO
	NSLog(@"IMPLEMENT ME");
	return [NSArray array];
}

- (void) setFileTypes: (in bycopy NSArray*) extensions
			 forUsage: (in bycopy NSString*) usage {
	// Specifies the extensions that are valid for a particular type of file
	NSLog(@"IMPLEMENT ME");
}

- (void) promptForFilesForUsage: (in bycopy NSString*) usage
					 forWriting: (BOOL) writing
						handler: (in byref NSObject<GlkFilePrompt>*) handler {
	// Will return quickly, then the handler will be told the results later
	NSLog(@"IMPLEMENT ME");
}

- (void) promptForFilesOfType: (in bycopy NSArray*) filetypes
				   forWriting: (BOOL) writing
					  handler: (in byref NSObject<GlkFilePrompt>*) handler {
	// Will return quickly, then the handler will be told the results later
	NSLog(@"IMPLEMENT ME");
}

// = Images =

- (void) setImageSource: (in byref id<GlkImageSource>) newSource {
	// Sets where we get our image data from
	NSLog(@"IMPLEMENT ME");
}

- (NSSize) sizeForImageResource: (glui32) imageId {
	// Retrieves the size of an image
	NSLog(@"IMPLEMENT ME");
	return NSMakeSize(0,0);
}

- (out byref id<GlkImageSource>) imageSource {
	// Retrieves the active image source
	NSLog(@"IMPLEMENT ME");
	return nil;
}

@synthesize delegate;
@synthesize bufferTarget;
@end
