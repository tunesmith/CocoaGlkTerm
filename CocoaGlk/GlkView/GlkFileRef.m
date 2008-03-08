//
//  GlkFileRef.m
//  CocoaGlk
//
//  Created by Andrew Hunter on 28/03/2005.
//  Copyright 2005 Andrew Hunter. All rights reserved.
//

#import "GlkFileRef.h"
#import "GlkFileStream.h"


@implementation GlkFileRef

// = Initialisation =

- (id) initWithPath: (NSString*) path {
	self = [super init];
	
	if (self) {
		pathname = [[path stringByStandardizingPath] copy];
		temporary = NO;
		
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(applicationWillTerminate:)
													 name: NSApplicationWillTerminateNotification
												   object: NSApp];
	}
	
	return self;
}

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver: self];
	
	if (temporary) {
		NSLog(@"Removing temporary file: %@", pathname);

		// Delete any temporary files when deallocated
		[[NSFileManager defaultManager] removeFileAtPath: pathname 
												 handler: nil];
	}
	
	[pathname release]; pathname = nil;
	
	[super dealloc];
}

- (void) applicationWillTerminate: (NSNotification*) not {
	if (temporary) {
		NSLog(@"Removing temporary file: %@", pathname);
		
		// Also delete any temporary files when the application terminates
		[[NSFileManager defaultManager] removeFileAtPath: pathname 
												 handler: nil];
	}
}

// = Temporaryness =

- (void) setTemporary: (BOOL) isTemp {
	temporary = isTemp;
}

// = The fileref protocol =

- (NSObject<GlkStream>*) createReadOnlyStream {
	GlkFileStream* stream = [[GlkFileStream alloc] initForReadingWithFilename: pathname];
	
	return [stream autorelease];
}

- (NSObject<GlkStream>*) createWriteOnlyStream; {
	GlkFileStream* stream = [[GlkFileStream alloc] initForWritingWithFilename: pathname];
	
	return [stream autorelease];
}

- (NSObject<GlkStream>*) createReadWriteStream {
	GlkFileStream* stream = [[GlkFileStream alloc] initForReadWriteWithFilename: pathname];
	
	return [stream autorelease];
}

- (void) deleteFile {
	[[NSFileManager defaultManager] removeFileAtPath: pathname 
											 handler: nil];
}

- (BOOL) fileExists {
	return [[NSFileManager defaultManager] fileExistsAtPath: pathname];
}

- (void) setAutoflush: (BOOL) newAutoflush {
	autoflush = newAutoflush;
}

- (BOOL) autoflushStream {
	return autoflush;
}

@end
