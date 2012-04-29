//
//  ProgramDetailViewController.h
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpringObject.h"

@interface ProgramDetailViewController : UITableViewController
@property (weak, nonatomic) SpringObject * dataSource;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UITextView *eligibilityText;
@property (weak, nonatomic) IBOutlet UITextView *costText;
@property (weak, nonatomic) IBOutlet UITextView *hoursText;
@property (weak, nonatomic) IBOutlet UILabel *phoneText;
@property (weak, nonatomic) IBOutlet UILabel *urlText;
@property (weak, nonatomic) IBOutlet UILabel *addressText;

@end
