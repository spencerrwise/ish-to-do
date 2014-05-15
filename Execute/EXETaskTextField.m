//
//  EXETaskTextField.m
//  Execute
//
//  Created by Spencer Wise on 3/27/14.
//  Copyright (c) 2014 Dos Leches. All rights reserved.
//

#import "EXETaskTextField.h"

@implementation EXETaskTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
		self.textColor = [UIColor blackColor];
		self.textAlignment = NSTextAlignmentCenter;
		self.returnKeyType = UIReturnKeyGo;
		self.font = [UIFont fontWithName:@"Futura" size:18.0f];
		self.tintColor = [UIColor colorWithRed:232/255.0 green:119/255.0 blue:79/255.0 alpha:1.0];

        self.placeholder = @"What ish you want to do?";
    }
    return self;
}

- (CGRect) textRectForBounds:(CGRect)bounds {
    
    CGRect rect = [super textRectForBounds: bounds];
    return CGRectInset(rect, 8.0f, 8.0f);
}


- (CGRect) editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
