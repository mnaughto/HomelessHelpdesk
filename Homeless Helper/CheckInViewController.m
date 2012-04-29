//
//  CheckInViewController.m
//  Homeless Helper
//
//  Created by Mac User on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController ()
@end

@implementation CheckInViewController {
    NSIndexPath * activeDutyRowPath;
    NSIndexPath * yearsServedLabelRowPath;
    NSIndexPath * yearsServedRowPath;
}
@synthesize genderSelection;
@synthesize veteranStatusSelection;
@synthesize dutyStatusSelection;
@synthesize disabledSelection;
@synthesize activeDutyRow;
@synthesize yearsServedLabelRow;
@synthesize yearsServedRow;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setGenderSelection:nil];
    [self setVeteranStatusSelection:nil];
    [self setDutyStatusSelection:nil];
    [self setDisabledSelection:nil];
    [self setActiveDutyRow:nil];
    [self setYearsServedLabelRow:nil];
    [self setYearsServedRow:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat selectorSize = 30;
    genderSelection.bounds = CGRectMake(genderSelection.bounds.origin.x, genderSelection.bounds.origin.y, genderSelection.bounds.size.width, selectorSize);
    veteranStatusSelection.bounds = CGRectMake(veteranStatusSelection.bounds.origin.x, veteranStatusSelection.bounds.origin.y, veteranStatusSelection.bounds.size.width, selectorSize);
    dutyStatusSelection.bounds = CGRectMake(dutyStatusSelection.bounds.origin.x, dutyStatusSelection.bounds.origin.y, dutyStatusSelection.bounds.size.width, selectorSize);
    disabledSelection.bounds = CGRectMake(disabledSelection.bounds.origin.x, disabledSelection.bounds.origin.y, disabledSelection.bounds.size.width, selectorSize);
    activeDutyRowPath = [NSIndexPath indexPathForRow:3 inSection:0];
    yearsServedLabelRowPath = [NSIndexPath indexPathForRow:4 inSection:0];
    yearsServedRowPath = [NSIndexPath indexPathForRow:5 inSection:0];
    //activeDutyRowPath = [self.tableView indexPathForCell:activeDutyRow];
    //yearsServedLabelRowPath = [self.tableView indexPathForCell:yearsServedLabelRow];
    //yearsServedRowPath = [self.tableView indexPathForCell:yearsServedRow];    
    
    //[self.tableView beginUpdates];
    //[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:activeDutyRowPath, yearsServedLabelRowPath, yearsServedRowPath, nil] withRowAnimation: UITableViewRowAnimationNone];
    //[self.tableView endUpdates];
    //[veteranStatusSelection setSelectedSegmentIndex:1];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //only one section, so no need to check
    NSInteger rowCount = [super tableView:tableView numberOfRowsInSection:section];
    if([veteranStatusSelection selectedSegmentIndex] != 0){
        //no is selected        
        rowCount -= 3; //number of rows to hide.
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    NSIndexPath * finalPath = indexPath;
    if([veteranStatusSelection selectedSegmentIndex] != 0){
        //no is selected
        if(finalPath.row >= activeDutyRowPath.row){
            NSInteger row = finalPath.row;
            finalPath = [NSIndexPath indexPathForRow:row + 3 inSection:0];
        }
    }
    cell = [super tableView:tableView cellForRowAtIndexPath:finalPath];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)veteranStatusSelected:(id)sender {
    [self.tableView beginUpdates];
    if([veteranStatusSelection selectedSegmentIndex] == 0){
        //yes is selected
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:activeDutyRowPath, yearsServedLabelRowPath, yearsServedRowPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
    } else {
        //no is selected
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:activeDutyRowPath, yearsServedLabelRowPath, yearsServedRowPath, nil] withRowAnimation: UITableViewRowAnimationNone];
    }
    [self.tableView endUpdates];
}
@end
