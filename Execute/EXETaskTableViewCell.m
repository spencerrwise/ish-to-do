//
//  EXETaskTableViewCell.m
//  Execute
//
//  Created by Spencer Wise on 3/27/14.
//  Copyright (c) 2014 Dos Leches. All rights reserved.
//

#import "EXETaskTableViewCell.h"

@implementation EXETaskTableViewCell

#pragma mark - Accessories

@synthesize task = _task;
@synthesize completed  = _completed;
@synthesize editGestureRecognizer = _editGestureRecognizer;




- (void) setTask: (NSString *)task {
    _task = task;
    self.textLabel.text = task;
}

- (void) setCompleted:(BOOL)completed{
    _completed = completed;
    self. backgroundColor = [UIColor colorWithRed:240/255.0 green:245/255.0 blue:247/255.0 alpha:1.0];
    
    if (_completed) {
        self.textLabel.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        [UIColor colorWithRed:240/255.0 green:245/255.0 blue:247/255.0 alpha:1.0];

        
    } else {
        self.textLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:65/255.0 green:229/255.0 blue:119/255.0 alpha:1.0];
    }
}

-(UITapGestureRecognizer *) editGestureRecognizer {
    if (_editGestureRecognizer == nil) {
        _editGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        _editGestureRecognizer.delegate =self;
        
        [self addGestureRecognizer: _editGestureRecognizer];
        
    }
    return _editGestureRecognizer;
}


#pragma mark - UITableviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
        
		self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
        
		UIView *view = [[UIView alloc] init];
		view.backgroundColor = [UIColor colorWithRed:39/255.0 green:183/255.0 blue:87/255.0 alpha:1.0];
        //view.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
		self.selectedBackgroundView = view;
	}
	return self;
}

- (void) setEditing: (BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    self.editGestureRecognizer.enabled =editing;
}

#pragma mark - UIGestureRecognizer


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self];
    
    return CGRectContainsPoint(self.contentView.frame, point);
}

@end
