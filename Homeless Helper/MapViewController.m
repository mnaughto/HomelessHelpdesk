//
//  MapViewController.m
//  Homeless Helper
//
//  Created by Mac User on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
@synthesize mapView;
@synthesize address;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [mapView setShowsUserLocation:NO];
}


- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) viewDidAppear:(BOOL)animated {
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    CLGeocodeCompletionHandler handler = ^(NSArray *placemarks, NSError *error){
        CLPlacemark *placemark = [placemarks lastObject];
        if(placemark){
            [mapView addAnnotation:[[MKPlacemark alloc ]initWithPlacemark:placemark]];
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.region.center, placemark.region.radius * 10, placemark.region.radius * 10);
            [mapView setRegion:region animated:YES];
        }
    };
    [coder geocodeAddressString:address completionHandler:handler];
}

- (IBAction)actionSelected:(id)sender {
    UIActionSheet * actions = [[UIActionSheet alloc] initWithTitle:address delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Maps", nil];
    [actions showFromBarButtonItem:sender animated:YES];
}

#pragma mark MKMapViewDelegate

-(MKAnnotationView *) mapView:(MKMapView *)mapView2 viewForAnnotation:(id<MKAnnotation>)annotation {
    NSString *reuseIdentifier;
    if([annotation class] == [MKUserLocation class]){
        reuseIdentifier = @"userLocation";
    } else {
        reuseIdentifier = @"reusable";
    }

    MKAnnotationView * view = [mapView2 dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if(!view){
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];        
    }
    
    return view;
}

-(void) mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated {
    
}

#pragma mark UIActionSheetDelegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString * urlString;
    switch (buttonIndex) {
        case 0:
            urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            break;
            
        default:
            break;
    }
}
@end
