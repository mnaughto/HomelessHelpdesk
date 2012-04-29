//
//  ProgramDetailViewController.m
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProgramDetailViewController.h"
#import "WebViewController.h"
#import "MapViewController.h"


@implementation ProgramDetailViewController {
    SpringObject * _dataSource;    
}
@synthesize detailText;
@synthesize eligibilityText;
@synthesize costText;
@synthesize hoursText;
@synthesize phoneText;
@synthesize urlText;
@synthesize addressText;

-(SpringObject *) dataSource {
    return _dataSource;
}

-(void) setDataSource:(SpringObject *)dataSource2 {    
    _dataSource = dataSource2;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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
    [self setDetailText:nil];
    [self setEligibilityText:nil];
    [self setCostText:nil];
    [self setAddressText:nil];
    [self setUrlText:nil];
    [self setPhoneText:nil];
    [self setHoursText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    detailText.text = [self.dataSource objectForKey:@"description"];    
    costText.text = [self.dataSource objectForKey:@"cost"];
    phoneText.text = [self.dataSource objectForKey:@"phone"];
    urlText.text = [self.dataSource objectForKey:@"website"];
    addressText.text = [self.dataSource objectForKey:@"address"];
    hoursText.text = [self.dataSource objectForKey:@"hours"];
    NSString* eligibilityString = [NSString string];
    NSDictionary* eligibility = [self.dataSource objectForKey:@"eligibility"];
    if([eligibility objectForKey:@"veteran"]){
        eligibilityString = [eligibilityString stringByAppendingString:@"Must be veteran.\n"];
    }
    if([eligibility objectForKey:@"disability"]){
        eligibilityString = [eligibilityString stringByAppendingString:@"Must have a disability\n"];        
    }
    //mention any age limitations (min, max, range)
    NSString* requiredGender = [eligibility objectForKey:@"gender"];
    if(requiredGender && ![requiredGender isEqualToString:@"N"]){
        if([requiredGender isEqualToString:@"F"]){
            eligibilityString = [eligibilityString stringByAppendingString:@"Must be female.\n"];
        } else if([requiredGender isEqualToString:@"M"]){
            eligibilityString = [eligibilityString stringByAppendingString:@"Must be male.\n"];
        }
    }
    eligibilityString = [eligibilityString stringByAppendingString:[eligibility objectForKey:@"note"]];
    eligibilityText.text = eligibilityString;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"urlView"]){
        WebViewController * next = [segue destinationViewController];
        next.url = [NSURL URLWithString:urlText.text];
    } else if([[segue identifier] isEqualToString:@"addressView"]){
        MapViewController * next = [segue destinationViewController];
        next.address = addressText.text;
    }
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
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

@end
