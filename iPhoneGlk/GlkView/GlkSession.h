//
//  GlkSession.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 09/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GlkClient/GlkSessionProtocol.h>
#import "GlkWindow.h"

///
/// Protocol implemented by objects that can act as a target for buffered operations
///
@protocol GlkBufferTarget<GlkBuffer>

@property (retain, nonatomic) GlkWindow* root;												// The root window
@property (retain, nonatomic) GlkWindow* lastRoot;											// The root window after the last time the buffer was flushed
@property (nonatomic)		  BOOL		 windowsNeedLayout;									// YES if something has occurred to necessitate re-arranging the windows

- (void) updateRootWindow;																	// Request to update the UI to reflect the value of the rootWindow property
- (void) layoutWindows;																		// Request to cause a layout operation

- (GlkWindow*) windowWithIdentifier: (int) windowId;										// Retrieves the window with the specified identifier

@end

///
/// Singleton object that represents a session with iPhone CocoaGlk
///
@interface GlkSession : NSObject<GlkSession,UIModalViewDelegate> {
	NSPort*					mainThreadPort;							// Port for communicating with the UI thread
	NSPort*					terpThreadPort;							// Port for communicating with the interpreter thread
	NSConnection*			mainThread;								// Connection to the main thread
	NSConnection*			terpThread;								// Connection to the interpreter thread
	
	id						delegate;								// The delegate for this session
	NSObject<GlkBufferTarget>* bufferTarget;						// The location where buffered operations should be sent
	
	BOOL					flushing;								// YES if we're in the process of flushing a buffer
}

@property (assign) id					delegate;					// The delegate for this session
@property (retain) NSObject<GlkBufferTarget>* bufferTarget;			// The location where buffered operations should be sent

- (void) startInterpreter;											// Launches the interpreter thread

@end

@interface NSObject(GlkSessionDelegate)

- (void) interpreterStarting: (GlkSession*) session;				// Called on the intepreter thread: indicates that things are set up and the interpreter about to start

@end