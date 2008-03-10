//
//  GlkPairWindow.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlkWindow.h"


///
/// Representation of a pair window
///
@interface GlkPairWindow : GlkWindow {
	// The two windows that make up the pair
	GlkWindow* keyWindow;					// The key window is used to determine the size of this window (when fixed)
	GlkWindow* leftWindow;					// Left window is the 'original' window when splitting
	GlkWindow* rightWindow;					// Right window is the 'new' window when splitting
	
	// The size of the window
	unsigned size;
	
	// Arrangement options
	BOOL fixed;								// Proportional arrangement if NO
	BOOL horizontal;						// Vertical arrangement if NO
	BOOL above;								// NO if left is above/left of right, YES otherwise	
	
	BOOL needsLayout;						// YES when this window needs to be laid out
}

@property (nonatomic, retain)	GlkWindow*	keyWindow;
@property (nonatomic, retain)	GlkWindow*	nonKeyWindow;
@property (nonatomic, retain)	GlkWindow*	leftWindow;
@property (nonatomic, retain)	GlkWindow*	rightWindow;

@property (nonatomic)	unsigned	size;
@property (nonatomic)	BOOL		fixed;
@property (nonatomic)	BOOL		horizontal;
@property (nonatomic)	BOOL		above;

@end
