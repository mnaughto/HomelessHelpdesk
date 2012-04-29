//
//  SearchViewController.m
//  Homeless Helper
//
//  Created by Mac User on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "SpringLink.h"
#import "SpringObject.h"
#import "ProgramDetailViewController.h"

@interface SearchViewController ()
-(void) handleSearch:(UISearchBar *) searchBar onField: (NSInteger) searchCategory;
@end

@implementation SearchViewController {
    NSDictionary * dataSource;
    NSMutableDictionary * organizationGrouping;
    NSMutableArray * organizationNames;
    NSIndexPath * lastSelected;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"detailView"]){
        ProgramDetailViewController * next = segue.destinationViewController;
        if(lastSelected && dataSource){
            NSString * orgName = [organizationNames objectAtIndex:lastSelected.section];
            NSMutableArray * programs = [organizationGrouping objectForKey:orgName];
            NSDictionary * program = [programs objectAtIndex:lastSelected.row];
            NSString* urlText = @"http://vrcapps.jelastic.servint.net/vrcdata/program/";
            urlText = [urlText stringByAppendingString:[program objectForKey:@"id"]];
            NSURL *url = [NSURL URLWithString:urlText];
            next.dataSource = [[SpringObject alloc] initWithContentsOfURL:url];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [organizationGrouping count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [organizationNames objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[organizationGrouping objectForKey:[organizationNames objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"reusable";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString * orgName = [organizationNames objectAtIndex:indexPath.section];
    NSMutableArray * programs = [organizationGrouping objectForKey:orgName];
    NSDictionary * program = [programs objectAtIndex:indexPath.row];
    cell.textLabel.text = [program objectForKey:@"name"];
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
    lastSelected = indexPath;
    [self performSegueWithIdentifier:@"detailView" sender:[tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark UISearchBarDelegate

-(void) searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self handleSearch:searchBar onField:selectedScope];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar onField:[searchBar selectedScopeButtonIndex]];
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self handleSearch:searchBar onField:[searchBar selectedScopeButtonIndex]];
}

-(void) handleSearch:(UISearchBar *)searchBar onField:(NSInteger)searchCategory {
    NSString* urlTest = @"http://vrcapps.jelastic.servint.net/vrcsearch/program/search?";
    if(searchCategory == 0){
        //searching by organization name
        urlTest = [urlTest stringByAppendingString:@"organization"];
    } else {
        //searching by program name
        urlTest = [urlTest stringByAppendingString:@"name"];
    }
    urlTest = [urlTest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:urlTest];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData* data, NSError * error){
        if(data){
            NSArray* result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
            //dataSource = result;
            organizationGrouping = [NSMutableDictionary dictionary];
            organizationNames = [NSMutableArray array];
            for(NSDictionary * link in result){
                //NSString* orgName = [[link child] objectForKey:@"organization"];
                NSString * orgName = [link objectForKey:@"organization"];
                if(![organizationGrouping objectForKey:orgName]){
                    [organizationGrouping setObject:[NSMutableArray array] forKey:orgName];
                    [organizationNames addObject:orgName];
                }
                NSMutableArray* programs = [organizationGrouping objectForKey:orgName];
                [programs addObject:link];
            }
            [self.tableView reloadData];
        }
    }];
}

@end
