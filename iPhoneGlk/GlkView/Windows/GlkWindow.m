//
//  GlkWindow.m
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import "GlkWindow.h"


@implementation GlkWindow

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[[UIColor whiteColor] set];
	UIRectFill(rect);
}

- (void)dealloc
{
	[super dealloc];
}

@synthesize closed;
@synthesize windowIdentifier;
@synthesize parentWindow;

// = Performing layout =

@dynamic glkSize;
- (GlkSize) glkSize {
	// Default size is the size of this window in pixels
	CGRect contentRect = [self bounds];
	GlkSize res;
	
	res.width = contentRect.size.width;
	res.height = contentRect.size.height;
	
	return res;
}

- (float) widthForFixedSize: (unsigned) size {
	// Default is pixels
	return size;
}

- (float) heightForFixedSize: (unsigned) size {
	// Default is pixels
	return size;
}

- (void) layoutInRect: (CGRect) parentRect {
	[self setFrame: parentRect];
	
	GlkSize newSize = self.glkSize;
	if (newSize.width != lastSize.width || newSize.height != lastSize.height) {
		NSLog(@"TODO: request a client synchronisation after layout");
		// [containingView requestClientSync];
	}
	lastSize = [self glkSize];
}

// = Acting as a stream =

@end
