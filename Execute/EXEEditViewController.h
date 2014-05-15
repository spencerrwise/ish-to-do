//
//  EXEEditViewController.h
//  Execute
//
//  Created by Spencer Wise on 3/27/14.
//  Copyright (c) 2014 Dos Leches. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EXEEditViewControllerDelegate;

@interface EXEEditViewController : UIViewController

@property (nonatomic, weak) id<EXEEditViewControllerDelegate> delegate;
@property (nonatomic) NSString *task; 

@end

@protocol EXEEditViewControllerDelegate  <NSObject>

@optional


- (void)editViewController:(EXEEditViewController *)editViewController didEditTask:(NSString *)task;

@end