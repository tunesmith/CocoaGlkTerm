//
//  GlkAppDelegate.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GlkSession.h"

@interface GlkAppDelegate : NSObject {
	UIWindow*	window;										// The main application window
	UIView*		contentView;								// The primary content view
	
	GlkSession*	session;									// The running (or finished) interpreter session
}

@property (retain)				UIWindow*	window;
@property (retain)				UIView*		contentView;

@property (retain, readonly)	GlkSession*	session;

@end
