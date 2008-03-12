//
//  GlkTextWindow.h
//  iPhoneGlk
//
//  Created by Andrew Hunter on 12/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GlkWindow.h"

@interface GlkTextWindow : GlkWindow {
	// TODO: for proper display characteristics, we're going to need to use a HTML view with some javascript for updating
	UITextView* textView;								// A view containing the text for this window
}

@end
