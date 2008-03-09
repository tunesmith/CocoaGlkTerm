//
//  main.m
//  iPhoneGlkTerm
//
//  Created by Andrew Hunter on 09/03/2008.
//  Copyright Andrew Hunter 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"iPhoneGlkTermAppDelegate");
    [pool release];
    return retVal;
}
