//
//  TOSCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "TOSCell.h"
#import "Models.h"

@implementation TOSCell

@synthesize checkBox;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TOSCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    NSString *tosTextHTML = @"I agree to the <a href =\"http://dealio.cinnux.com/pre-release-terms-of-service/\">Terms of Service</a>";
    [tosText loadHTMLString:tosTextHTML baseURL:nil];
    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkBoxTapped:)];
    [checkBox addGestureRecognizer:tapGestureRecognizer];

    return self;
}

-(IBAction)checkBoxTapped:(id)sender
{
    checkBox.highlighted = !checkBox.highlighted;

    RegistrationData.instance.acceptedTOS = checkBox.highlighted;
}

-(void)setCheckboxFromData
{
    checkBox.highlighted = RegistrationData.instance.acceptedTOS;
}

#pragma mark UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

@end
