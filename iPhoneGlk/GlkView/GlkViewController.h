//
//  GlkViewController.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GlkClient/GlkBuffer.h>

#import "GlkSession.h"
#import "GlkWindow.h"

///
/// The main UIViewController class for the iPhone Glk control. This also provides the implementation of the
/// GlkBuffer protocol: that is, it is where requests from the interpreter thread end up (and perhaps get routed
/// to a lower-level UI element)
///
/// The view here is just a container: it will have subviews added later on to represent the windows created by
/// the interpreter.
///
@interface GlkViewController : UIViewController<GlkBufferTarget> {
	GlkWindow*	root;											// The root window
	GlkWindow*	lastRoot;										// The last root window
	BOOL		windowsNeedLayout;								// YES if the windows in this controller need to be laid out
}

@property (retain, nonatomic) GlkWindow* root;
@property (retain, nonatomic) GlkWindow* lastRoot;

@end
