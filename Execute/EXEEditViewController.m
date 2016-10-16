//
//  EXEEditViewController.m
//  Execute
//
//  Created by Spencer Wise on 3/27/14.
//  Copyright (c) 2014 Dos Leches. All rights reserved.
//

#import "EXEEditViewController.h"
#import "EXETaskTextField.h"

@interface EXEEditViewController () <UITextFieldDelegate>
@property (nonatomic, readonly) EXETaskTextField *textField;
@property (nonatomic) CGRect keyboardFrame;

@end


@implementation EXEEditViewController

#pragma mark - Accessors

@synthesize textField = _textField;
@synthesize task = _task;

- (EXETaskTextField *) textField {
    if (_textField ==nil) {
        _textField = [[EXETaskTextField alloc] init];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
    }
    return _textField;
}

- (void)setTask: (NSString *)task {
    _task = task;
    self.textField.text = task;
}


#pragma mark - NSObject

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"Edit";
    self.view.backgroundColor   = [UIColor colorWithRed:65/255.0 green:229/255.0 blue:119/255.0 alpha:1.0];
    self.textField.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    
    [self.view addSubview:self.textField];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize size = self.view.bounds.size;
    
    self.textField.frame =CGRectMake(10.0f, roundf((size.height - self.keyboardFrame.size.height + self.topLayoutGuide.length - 60.0f) / 2.0f), size.width - 20.0f , 60.0f);
}


#pragma mark - Actions

-(void) save:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(editViewController:didEditTask:)]){
        [self.delegate editViewController:self didEditTask:self.textField.text]; 
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private

- (void) keyboardWillChangeFrame: (NSNotification *)notifcation {
    NSValue *value = notifcation.userInfo[UIKeyboardFrameEndUserInfoKey];
    self.keyboardFrame = [value CGRectValue];
    
    
    NSTimeInterval duration = [notifcation.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self viewDidLayoutSubviews];
    }];
   
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (text.length ==0) {
    
        return NO;
        
    }
    
    [self save:textField];
    
    return NO;
}


@end
