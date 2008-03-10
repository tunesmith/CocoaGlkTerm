//
//  GlkSession.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 09/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GlkClient/GlkSessionProtocol.h>

///
/// Singleton object that represents a session with iPhone CocoaGlk
///
@interface GlkSession : NSObject<GlkSession> {
	NSPort*			mainThreadPort;									// Port for communicating with the UI thread
	NSPort*			terpThreadPort;									// Port for communicating with the interpreter thread
	NSConnection*	mainThread;										// Connection to the main thread
	NSConnection*	terpThread;										// Connection to the interpreter thread
	
	id				delegate;										// The delegate for this session
}

@property (assign) id delegate;										// The delegate for this session

- (void) startInterpreter;											// Launches the interpreter thread

@end

@interface NSObject(GlkSessionDelegate)

- (void) interpreterStarting: (GlkSession*) session;				// Called on the intepreter thread: indicates that things are set up and the interpreter about to start

@end