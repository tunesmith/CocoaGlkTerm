//
//  GlkPairWindow.m
//  iPhoneGlk
//
//  Created by Andrew Hunter on 10/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import "GlkPairWindow.h"


@implementation GlkPairWindow

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code here.
}

- (void)dealloc
{
	[super dealloc];
}

// = Setting the windows that make up this pair =

@dynamic keyWindow;
@dynamic nonKeyWindow;
@dynamic leftWindow;
@dynamic rightWindow;
@dynamic size;
@dynamic fixed;
@dynamic above;

- (void) setKeyWindow: (GlkWindow*) newKey {
	[keyWindow release];
	
	keyWindow = [newKey retain];
	
	needsLayout = YES;
}

- (GlkWindow*) nonKeyWindow {
	if (keyWindow == leftWindow)
		return rightWindow;
	else
		return leftWindow;
}

- (void) setLeftWindow: (GlkWindow*) newLeft {
	leftWindow.parentWindow = nil;
	[leftWindow removeFromSuperview];
	[leftWindow release]; 
	
	leftWindow = [newLeft retain];
	leftWindow.parentWindow = self;
	//[leftWindow setScaleFactor: scaleFactor];
	
	needsLayout = YES;
}

- (void) setRightWindow: (GlkWindow*) newRight {
	rightWindow.parentWindow = nil;
	[rightWindow removeFromSuperview];
	[rightWindow release]; 
	
	rightWindow = [newRight retain];
	rightWindow.parentWindow = self;
	//[rightWindow setScaleFactor: scaleFactor];
	
	needsLayout = YES;
}

- (GlkWindow*) keyWindow {
	return keyWindow;
}

- (GlkWindow*) leftWindow {
	return leftWindow;
}

- (GlkWindow*) rightWindow {
	return rightWindow;
}

// = Size and arrangement =

- (void) setSize: (unsigned) newSize {
	size = newSize;
	
	needsLayout = YES;
}

- (void) setFixed: (BOOL) newFixed {
	fixed = newFixed;
	
	needsLayout = YES;
}

- (void) setHorizontal: (BOOL) newHorizontal {
	horizontal = newHorizontal;
	
	needsLayout = YES;
}

- (void) setAbove: (BOOL) newAbove {
	above = newAbove;
}

- (unsigned) size {
	return size;
}

- (BOOL) fixed {
	return fixed;
}

- (BOOL) horizontal {
	return horizontal;
}

- (BOOL) above {
	return above;
}

// = Performing layout =

- (float) widthForFixedSize: (unsigned) sz {
	if (keyWindow && [keyWindow closed]) {
		[keyWindow release]; keyWindow = nil;
	}
	
	if (keyWindow) {
		return [keyWindow widthForFixedSize: sz];
	} else {
		return 0;
	}
}

- (float) heightForFixedSize: (unsigned) sz {
	if (keyWindow && [keyWindow closed]) {
		[keyWindow release]; keyWindow = nil;
	}
	
	if (keyWindow) {
		return [keyWindow heightForFixedSize: sz];
	} else {
		return 0;
	}
}

- (void) layoutInRect: (CGRect) parentRect {
	if (needsLayout || !CGRectEqualToRect(parentRect, [self frame])) {
		// Set our own frame
		[self setFrame: parentRect];
		
		CGRect bounds = [self bounds];
		
		// Work out the sizes for the child windows
		float availableSize = horizontal?parentRect.size.width:parentRect.size.height;
		float leftSize, rightSize;
		
		if (fixed) {
			if (horizontal) {
				rightSize = [rightWindow widthForFixedSize: size];
			} else {
				rightSize = [rightWindow heightForFixedSize: size];
			}
		} else {
			rightSize = (availableSize * ((float)size))/100.0;
		}
		
		if (rightSize > availableSize) rightSize = availableSize-1.0;
		
		rightSize = floorf(rightSize);		
		leftSize = floorf(availableSize - rightSize);
		
		CGRect leftRect;
		CGRect rightRect;
		
		if (horizontal) {
			if (above) {
				leftRect.origin.x = bounds.origin.x + rightSize;
				rightRect.origin.x = bounds.origin.x;
			} else {
				leftRect.origin.x = bounds.origin.x;
				rightRect.origin.x = bounds.origin.x + leftSize;
			}
			
			leftRect.size.width = leftSize;
			rightRect.size.width = rightSize;
		} else {
			if (!above) {
				leftRect.origin.y = bounds.origin.y + rightSize;
				rightRect.origin.y = bounds.origin.y;
			} else {
				leftRect.origin.y = bounds.origin.y;
				rightRect.origin.y = bounds.origin.y + leftSize;
			}
			
			leftRect.size.height = leftSize;
			rightRect.size.height = rightSize;
		}
		
		if (leftWindow.parentWindow != self) {
			NSLog(@"GlkPairWindow: left parent does not match self");
			return;
		}
		
		if (rightWindow.parentWindow != self) {
			NSLog(@"GlkPairWindow: right parent does not match self");
			return;
		}
		
		// Perform the layout
		if ([leftWindow superview] != self) {
			[leftWindow removeFromSuperview];
			[self addSubview: leftWindow];
		}
		
		if ([rightWindow superview] != self) {
			[rightWindow removeFromSuperview];
			[self addSubview: rightWindow];
		}
		
		[leftWindow layoutInRect: leftRect];
		[rightWindow layoutInRect: rightRect];
		
		// TODO: force a redisplay
		// [self setNeedsDisplay: YES];
		
		needsLayout = NO;
	} else {
		// Nothing major to do, but pass the buck anyway
		[leftWindow layoutInRect: leftWindow.frame];
		[rightWindow layoutInRect: rightWindow.frame];
	}
	
	GlkSize newSize = [self glkSize];
	if (newSize.width != lastSize.width || newSize.height != lastSize.height) {
		NSLog(@"TODO: request a client synchronisation");
		// [containingView requestClientSync];
	}
	lastSize = [self glkSize];
}

// = Flushing the buffer =

- (void) bufferIsFlushing {
	[super bufferIsFlushing];
	
	[leftWindow bufferIsFlushing];
	[rightWindow bufferIsFlushing];
}

- (void) bufferHasFlushed {
	[super bufferHasFlushed];
	
	[leftWindow bufferHasFlushed];
	[rightWindow bufferHasFlushed];
}

@end
