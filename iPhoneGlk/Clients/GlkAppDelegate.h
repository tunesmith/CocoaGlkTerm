//
//  GlkAppDelegate.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GlkSession.h"
#import "GlkViewController.h"

@interface GlkAppDelegate : NSObject {
	UIWindow*			window;								// The main application window
	GlkViewController*	content;							// The controller managing primary content view
	
	GlkSession*	session;									// The running (or finished) interpreter session
}

@property (retain)				UIWindow*			window;
@property (retain)				GlkViewController*	content;

@property (retain, readonly)	GlkSession*			session;

@end
