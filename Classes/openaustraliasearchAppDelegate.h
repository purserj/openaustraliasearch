//
//  openaustraliasearchAppDelegate.h
//  openaustraliasearch
//
//  Created by James Purser on 24/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class openaustraliasearchViewController;

@interface openaustraliasearchAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    openaustraliasearchViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet openaustraliasearchViewController *viewController;

@end

