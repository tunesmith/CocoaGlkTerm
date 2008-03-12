//
//  GlkTextWindow.m
//  iPhoneGlk
//
//  Created by Andrew Hunter on 12/03/2008.
//  Copyright 2008 Andrew Hunter. All rights reserved.
//

#import "GlkTextWindow.h"


@implementation GlkTextWindow

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		textView = [[UITextView alloc] init];
		
		textView.editable = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
}

- (void)dealloc
{
	[super dealloc];
}

// = Performing layout =

// TODO: measure the size of the fixed-pitch font for fixed layout

- (void) layoutInRect: (CGRect) parentRect {
	if (textView.superview != self) {
		[textView removeFromSuperview];
		[self addSubview: textView];
	}

	[super layoutInRect: parentRect];
	[textView setFrame: [self bounds]];
}

// = Acting as a stream =

- (void) putString: (NSString*) string {
	// Text views aren't mutable, so we create a mutable string, edit and put back.
	// (I see Apple have stolen this brilliant innovation from .NET's RichText view, except without even the
	// idiotic 'move the UI insertion point to do programmatic insertion' design)

	// Yeah, really slow. The real solution is to use an HTML view and some JavaScript to do the updates.
	NSMutableString* mutableText = [textView.text mutableCopy];
	[mutableText appendString: string];
	textView.text = mutableText;
	[mutableText release];
}

@end
