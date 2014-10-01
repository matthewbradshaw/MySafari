//
//  ViewController.m
//  MySafari
//
//  Created by Matthew Bradshaw on 10/1/14.
//  Copyright (c) 2014 Matthew Bradshaw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) loadURLString: (NSString *) urlString {
    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text hasPrefix:@"http://"]) {
        [self loadURLString:textField.text];
    }
    else
    {
        [self loadURLString: [NSString stringWithFormat:@"http://%@", textField.text ]];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSURL *currentURL = self.webView.request.URL;
    NSString *currentURLString = [currentURL absoluteString];
    self.urlTextField.text = currentURLString;
}

- (IBAction)quickClearTextField:(id)sender {
    self.urlTextField.text = @"";
}


- (IBAction)onBackButtonPressed:(id)sender {
    if (self.webView.canGoBack == YES) {
        [self.webView goBack];
    }
}

- (IBAction)onForwardButtonPressed:(id)sender {
    if (self.webView.canGoForward == YES) {
        [self.webView goForward];
    }
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}

- (IBAction)onPlusButtonPressed:(id)sender {
    UIAlertView * alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    [alertView addButtonWithTitle: @"Coming Soon"];
    [alertView show];

}








@end
