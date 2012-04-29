//
//  MapViewController.h
//  Homeless Helper
//
//  Created by Mac User on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, UIActionSheetDelegate>
@property (strong) NSString* address;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)actionSelected:(id)sender;

@end
