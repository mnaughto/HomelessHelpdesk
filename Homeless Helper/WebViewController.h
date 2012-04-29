//
//  WebViewController.h
//  Homeless Helper
//
//  Created by Mac User on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>
@property (strong) NSURL *url;
- (IBAction)backButtonSelected:(id)sender;
- (IBAction)forwardButtonSelected:(id)sender;
- (IBAction)refreshButtonSelected:(id)sender;
- (IBAction)stopButtonSelected:(id)sender;
- (IBAction)actionButtonSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *uiWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stopButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@end
