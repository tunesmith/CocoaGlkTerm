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

// = Flushing the buffer =

- (void) bufferIsFlushing {
	// Default action is to catch flies
}

- (void) bufferHasFlushed {
	// The horrible taste of flies fails to wake us up
}

// = Acting as a stream =
// Control

- (void) closeStream {
	// Nothing to do really
}

- (void) setPosition: (in int) position
		  relativeTo: (in enum GlkSeekMode) seekMode {
	// No effect
}

- (unsigned) getPosition {
	// Spec isn't really clear on what do for window streams. We just say the position is always 0
	return 0;
}

// Writing

- (void) putChar: (unichar) ch {
	unichar buf[1];
	
	buf[0] = ch;
	
	[self putString: [NSString stringWithCharacters: buf
											 length: 1]];
}

- (void) putString: (NSString*) string {
	// We're blank: nothing to do
}

- (void) putBuffer: (NSData*) buffer {
	// Assume that buffers are in ISO Latin-1 format
	NSString* string = [[[NSString alloc] initWithBytes: [buffer bytes]
												 length: [buffer length]
											   encoding: NSISOLatin1StringEncoding] autorelease];
	
	// Put the string
	[self putString: string];
}

// = Reading =

- (unichar) getChar {
	return 0;
}

- (NSString*) getLineWithLength: (int) len {
	return nil;
}

- (NSData*) getBufferWithLength: (unsigned) length {
	return nil;
}

// = Styles =

- (void) setImmediateStyleHint: (unsigned) hint
					   toValue: (int) value {
}

- (void) clearImmediateStyleHint: (unsigned) hint {
}

- (void) setCustomAttributes: (NSDictionary*) customAttributes {
}

- (void) setStyle: (int) styleId {
	style = styleId;
	
	/*
	if (immediateStyle) {
		[immediateStyle release];
		immediateStyle = nil;
	}
	 */
}

- (int) style {
	return style;
}

// = Hyperlinks =

- (void) setHyperlink: (unsigned int) value {
	NSLog(@"TODO: hyperlinks");
	//[linkObject release];
	//linkObject = [[NSNumber alloc] initWithUnsignedInt: value];
}

- (void) clearHyperlink {
	//[linkObject release];
	//linkObject = nil;
}

@end
