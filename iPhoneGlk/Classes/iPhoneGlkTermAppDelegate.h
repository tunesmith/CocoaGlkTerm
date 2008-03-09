//
//  iPhoneGlkTermAppDelegate.h
//  iPhoneGlkTerm
//
//  Created by Andrew Hunter on 09/03/2008.
//  Copyright Andrew Hunter 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyView;

@interface iPhoneGlkTermAppDelegate : NSObject {
    UIWindow *window;
    MyView *contentView;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MyView *contentView;

@end
