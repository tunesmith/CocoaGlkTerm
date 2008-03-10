//
//  GlkWindow.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GlkView/GlkEvent.h>
#import <GlkClient/GlkStreamProtocol.h>

///
/// The base class for a Glk window
///
@class GlkPairWindow;
@interface GlkWindow : UIView<GlkStream> {
	GlkPairWindow*				parentWindow;					// The pair window that 'owns' this window, or NULL for the root window (or windows outside the hierarchy)
	
	BOOL						closed;							// YES if this window is closed
	unsigned					windowIdentifier;				// This window's unique identifier number
	
	int							style;							// The active stream style
	BOOL						forceFixed;						// YES if we're forcing the style to be fixed-pitch
	
	NSObject<GlkEventReceiver>*	target;							// Where events for this window should be sent
	
	GlkSize						lastSize;						// The size of this window the last time it was resized
}

@property (nonatomic)			BOOL			closed;			// YES if the window is closed
@property (nonatomic)			unsigned		windowIdentifier;	// The window identifier
@property (nonatomic, assign)	GlkPairWindow*	parentWindow;	// The window that owns this window

// Layout
@property (nonatomic, readonly) GlkSize			glkSize;		// The size of the window in Glk characters
- (float) widthForFixedSize: (unsigned) sz;						// Given a fixed size in Glk characters, works out how wide the CGRect for this window should be
- (float) heightForFixedSize: (unsigned) sz;					// Similar to widthForFixedSize, but returns height instead
- (void) layoutInRect: (CGRect) parentRect;						// Requests that this window lay itself out in the specified rectangle

// Flushing the buffer
- (void) bufferIsFlushing;										// Indicates that we're flushing the buffers
- (void) bufferHasFlushed;										// Indicates that we've finished flushing the buffers

@end

#import "GlkPairWindow.h"