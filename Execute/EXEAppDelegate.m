//
//  EXEAppDelegate.m
//  Execute
//
//  Created by Spencer Wise on 3/18/14.
//  Copyright (c) 2014 Dos Leches. All rights reserved.
//

#import "EXEAppDelegate.h"
#import "EXEListViewController.h"


@implementation EXEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    self.window.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
	navigationBar.barTintColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
	navigationBar.tintColor = [UIColor colorWithRed:70/255.0 green:79/255.0 blue:84/255.0 alpha:1.0];
	navigationBar.titleTextAttributes = @{
                                          NSForegroundColorAttributeName: [UIColor colorWithRed:70/255.0 green:79/255.0 blue:84/255.0 alpha:1.0],
                                          NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18.0f]
                                          };

    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
	[barButtonItem setTitleTextAttributes:@{
                                            NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.0f]
                                            } forState:UIControlStateNormal];
    
    UIViewController *viewController = [[EXEListViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
    
    
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
