//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Michael Sevy on 3/16/15.
//  Copyright (c) 2015 Michael Sevy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;

@property NSMutableArray *taskArray;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.taskArray = [NSMutableArray new];
    //self.editing = false;
}


#pragma mark -- Editing (not funtional to get Edit button to switch to "Done"??
- (IBAction)onEditButtonPress:(UIBarButtonItem *)sender {
        //if you call method does the opposite editing
    [self.taskTableView setEditing:!self.taskTableView.editing animated:true];
    if (self.taskTableView.editing){
        NSLog(@"Editing");
        //self.editing = false;
//        [self.taskTableView setEditing:false animated:true];
//        sender.style = UIBarButtonItemStylePlain;
//        sender.title = @"Edit";
        [sender setTitle:@"Done"];
    }else {
        [sender setTitle:@"Edit"];

        //self.editing = true;
//        [self.taskTableView setEditing:true animated:true];
//        sender.style = UIBarButtonItemStyleDone;
//        sender.title = @"Done";
//
//        [self.taskTableView reloadData];
    }
}

#pragma mark -- Deleting items -works except for the Cancel action only deletes??
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{   //settign up the alert views
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cancel" message:@"Cancel" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];

        alertView.tag = indexPath.row;
        [alertView show];
    }
}
//conditional with certain button tapped
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.taskArray removeObjectAtIndex:alertView.tag];
        [self.taskTableView reloadData];

    } else  {
        [self.taskTableView reloadData];
    }
}

#pragma mark -- Moving items around on the tableViewCells
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    NSString *taskString = [self.taskArray objectAtIndex:sourceIndexPath.row];
    [self.taskArray removeObject:taskString];
    [self.taskArray insertObject:taskString atIndex:destinationIndexPath.row];

    [self.taskTableView reloadData];
}

#pragma mark Adding taskTextFields data to the taskArray
- (IBAction)onAddButtonPressed:(UIButton *)sender {

    if ([self.taskTextField.text length] > 0) {
    [self.taskArray addObject:self.taskTextField.text];
    [self.taskTableView reloadData];
    self.taskTextField.text = nil;
    [self.taskTextField resignFirstResponder];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    return [self.taskArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReminderCell"];
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];

    return cell;
}

# pragma mark -- Swip to prioritize???
//have a custom class for the task to store the color in the array
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
//    swipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [cell addGestureRecognizer:swipe];

#pragma mark -- half of the swipe to delete is working need to try and change colors with it too
-(IBAction)swipeHandler:(UIGestureRecognizer *)sender   {

    self.taskTextField.textColor = [UIColor yellowColor];
    [self.taskTableView reloadData];
}

#pragma mark Change textColor to green when Item is tapped on
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        cell.textLabel.textColor = [UIColor greenColor];
}


@end
