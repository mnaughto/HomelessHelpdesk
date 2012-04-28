//
//  ServiceTableViewController.h
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpringLinkArray.h"

@interface ServiceTableViewController : UITableViewController
@property (weak) SpringLinkArray* dataSource;
@end
