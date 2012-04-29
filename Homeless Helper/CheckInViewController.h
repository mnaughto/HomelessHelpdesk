//
//  CheckInViewController.h
//  Homeless Helper
//
//  Created by Mac User on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSelection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *veteranStatusSelection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dutyStatusSelection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *disabledSelection;
@property (weak, nonatomic) IBOutlet UITableViewCell *activeDutyRow;
@property (weak, nonatomic) IBOutlet UITableViewCell *yearsServedLabelRow;
@property (weak, nonatomic) IBOutlet UITableViewCell *yearsServedRow;
- (IBAction)veteranStatusSelected:(id)sender;

@end