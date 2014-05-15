//
//  EXEListViewController.m
//  Execute
//
//  Created by Spencer Wise on 3/21/14.
//  Copyright (c) 2014 Dos Leches. All rights reserved.
//

#import "EXEListViewController.h"
#import "EXETaskTableViewCell.h"
#import "EXEEditViewController.h"
#import "EXETaskTextField.h"

@interface EXEListViewController () <UITextFieldDelegate, EXEEditViewControllerDelegate>



@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) NSMutableArray *completedTasks;
@property (nonatomic) NSIndexPath *editingIndexPath;
@property (nonatomic,readonly) EXETaskTextField *textField;

@end

@implementation EXEListViewController

#pragma - Accessors

@synthesize textField = _textField;

- (EXETaskTextField *)textField {
    if (!_textField) {
        _textField = [[EXETaskTextField alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
        _textField.delegate = self;
    }
    return _textField;
}


#pragma mark - UIViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    
    //self.title = @"ISHtoDO";
    
    
	[self.tableView registerClass:[EXETaskTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.tableView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    
    [self.tableView registerClass: [EXETaskTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.12];
	self.tableView.separatorInset = UIEdgeInsetsZero;
    
    self.tableView.rowHeight = 60.0f;
    self.tableView.tableHeaderView = self.textField;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit:)];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *loadedTasks = [[NSUserDefaults standardUserDefaults] arrayForKey:@"tasks"];
    self.tasks = [[NSMutableArray alloc] initWithArray:loadedTasks];
    
    loadedTasks = [userDefaults arrayForKey:@"completedTasks"];
    self.completedTasks = [[NSMutableArray alloc] initWithArray:loadedTasks];
    
    
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	if (self.tasks.count == 0 && self.completedTasks.count == 0) {
		[self.textField becomeFirstResponder];
        
        
	}
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if(editing){
        [self.textField resignFirstResponder];
        self.navigationItem.rightBarButtonItem.title = @"Done";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self.textField resignFirstResponder];
}


#pragma mark - Actions

- (void)toggleEdit:(id)sender {
    [self setEditing: !self.editing animated: YES];
    
    
}

- (void)editTask: (UITapGestureRecognizer *)sender {
    
    self.editingIndexPath = [self.tableView indexPathForCell: (UITableViewCell *)sender.view];
    
    EXEEditViewController *viewController = [[EXEEditViewController alloc] init];
    viewController.delegate = self;
    viewController.task = [self taskForIndexPath: self.editingIndexPath];
    [self.navigationController pushViewController:viewController animated:YES];
    
    [self setEditing:NO animated: YES];
    
}

#pragma mark - Private

- (void)save {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:self.tasks forKey:@"tasks"];
	[userDefaults setObject:self.completedTasks forKey:@"completedTasks"];
	[userDefaults synchronize];
}

- (NSMutableArray *) arrayForSection: (NSInteger) section {
    if (section ==0) {
        return self.tasks;
    }
    
    return self.completedTasks;
}
- (NSString *)taskForIndexPath:(NSIndexPath *)indexPath{
    return [self arrayForSection:indexPath.section][indexPath.row];
}


- (void)setTask:(NSString *)task forIndexPath: (NSIndexPath *)indexPath {
    NSMutableArray *array = [self arrayForSection:indexPath.section];
    array[indexPath.row] = task;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self save];
}


#pragma mark - UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return[[self arrayForSection:section] count];
   }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EXETaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.editGestureRecognizer addTarget:self action:@selector(editTask:)];
    
    NSString *task = [self arrayForSection:indexPath.section] [indexPath.row];
    cell.task = task;
    cell.completed = indexPath.section ==1;


    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[self arrayForSection:indexPath.section] removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self save];
}

-(BOOL) tableView:(UITableView *) tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.section==0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSMutableArray *array = [self arrayForSection:fromIndexPath.section];
    
    NSString *task = array[fromIndexPath.row];
    [array removeObjectAtIndex:fromIndexPath.row];
    [array insertObject:task atIndex:toIndexPath.row];
    
    
    [tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    
    [self save];
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textField resignFirstResponder];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	[tableView beginUpdates];

    
	[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
	// Tapped an uncompleted task. Time to complete it!
	if (indexPath.section == 0) {
        
		NSString *task = self.tasks[indexPath.row];
		[self.tasks removeObjectAtIndex:indexPath.row];
		[self.completedTasks insertObject:task atIndex:0];
        
        
        
		[tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationTop];
        
        
	}
    
	// Tapped a completed task. Time to uncomplete it!
	else {
		NSString *task = self.completedTasks[indexPath.row];
		[self.completedTasks removeObjectAtIndex:indexPath.row];
		[self.tasks insertObject:task atIndex:0];
        
		[tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	}
    
	[tableView endUpdates];
    
	[self save];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self setEditing:NO animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (text.length ==0) {
        textField.text = nil;
        [textField resignFirstResponder];
        return NO;
    
    }
    

    [self.tasks insertObject:text atIndex:0];
    
    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    
  
    textField.text = nil;
    
    [self save];
    
    
    return NO;
}


#pragma mark - EXEEditViewControllerDelegate

- (void)editViewController:(EXEEditViewController *)editViewController didEditTask:(NSString *)task{
    [self setTask: task forIndexPath:self.editingIndexPath];
}

@end
