//
//  WebViewController.m
//  Homeless Helper
//
//  Created by Mac User on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController {
    NSURL * _url;
}
@synthesize uiWebView;
@synthesize refreshButton;
@synthesize stopButton;
@synthesize backButton;
@synthesize forwardButton;

-(NSURL*) url {
    return _url;
}

-(void) setUrl:(NSURL *)url2 {
    _url = url2;
}

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSURLRequest * request = [NSURLRequest requestWithURL:[self url]];
    [uiWebView loadRequest:request];
}

- (void)viewDidUnload
{
    [self setRefreshButton:nil];
    [self setStopButton:nil];
    [self setBackButton:nil];
    [self setForwardButton:nil];
    [self setUiWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UIWebViewDelegate
-(void) webViewDidStartLoad:(UIWebView *)webView{
    [refreshButton setEnabled:NO];
    [stopButton setEnabled:YES];
    backButton.enabled = [webView canGoBack];
    forwardButton.enabled = [webView canGoForward];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [refreshButton setEnabled:YES];
    [stopButton setEnabled:NO];
    backButton.enabled = [webView canGoBack];
    forwardButton.enabled = [webView canGoForward];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)backButtonSelected:(id)sender {
    [uiWebView goBack];
}

- (IBAction)forwardButtonSelected:(id)sender {
    [uiWebView goBack];
}

- (IBAction)refreshButtonSelected:(id)sender {
    [uiWebView reload];
}

- (IBAction)stopButtonSelected:(id)sender {
    [uiWebView stopLoading];
}

- (IBAction)actionButtonSelected:(id)sender {
    UIActionSheet* actions = [[UIActionSheet alloc] initWithTitle:[[[uiWebView request] URL] description] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", @"Copy URL", nil];
    [actions showFromBarButtonItem:sender animated:YES];
}

#pragma mark UIActionSheetDelegate

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [UIPasteboard generalPasteboard].string = [[[uiWebView request] URL] description];
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[[uiWebView request] URL]];
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            break;
        default:
            //[actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            break;
    }
}

-(void) actionSheetCancel:(UIActionSheet *)actionSheet {
    //[actionSheet dismissWithClickedButtonIndex:[actionSheet cancelButtonIndex] animated:YES];
}

@end
