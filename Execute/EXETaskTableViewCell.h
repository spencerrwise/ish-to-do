//
//  EXETaskTableViewCell.h
//  Execute
//
//  Created by Spencer Wise on 3/27/14.
//  Copyright (c) 2014 Dos Leches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXETaskTableViewCell : UITableViewCell

@property (nonatomic) NSString *task;
@property (nonatomic) BOOL completed;
@property (nonatomic, readonly) UITapGestureRecognizer *editGestureRecognizer;

@end
