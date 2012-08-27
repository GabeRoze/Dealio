//
//  ThreeButtonTableCell.m
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThreeButtonTableCell.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
//#import <SenTestingKit/SenTestingKit.h>
#import "TheRestaurantAppDelegate.h"
#import "CalculationHelper.h"
#import "ChangePasswordViewController.h"
#import "UserProfileViewController.h"

@implementation ThreeButtonTableCell

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ThreeButtonTableCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePasswordTapped:)];
    [passwordButtonImageView addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedbackTapped:)];
    [feedbackButtonImageView addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bugReportTapped:)];
    [bugReportButtonImageView addGestureRecognizer:tapGestureRecognizer];

    return self;
}

-(IBAction)changePasswordTapped:(id)sender
{
//    NSLog(@"password change tap");
    ChangePasswordViewController *changePasswordViewController = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    TheRestaurantAppDelegate *theRestaurantAppDelegate = (TheRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [self.superview addSubview:changePasswordViewController.view];

//    UserProfileViewController *userProfileViewController = (UserProfileViewController *)[theRestaurantAppDelegate.rootController.viewControllers objectAtIndex:0];
//    [userProfileViewController.view addSubview:changePasswordViewController.view];
//    [NSNotificationCenter.defaultCenter postNotificationName:@"presentChangePasswordView" object:nil];
    [theRestaurantAppDelegate.rootController presentModalViewController:changePasswordViewController animated:YES];

//    [theRestaurantAppDelegate.rootController presentModalViewController:changePasswordViewController animated:YES];
}

-(IBAction)feedbackTapped:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        [self presentEmailViewWithSubject:@"Dealio iPhone - Feedback" andTitle:@"Feedback"];
    }
    else
    {
        NSLog(@"can't send mail");
    }
}

-(IBAction)bugReportTapped:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        [self presentEmailViewWithSubject:@"Dealio iPhone - Bug Report" andTitle:@"Bug Report"];
    }
    else
    {
        NSLog(@"can't send mail");
    }
}

-(void)presentEmailViewWithSubject:(NSString *)subject andTitle:(NSString *)title
{
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    [mailViewController setToRecipients:[[NSArray alloc] initWithObjects:@"support@cinnux.com",nil]];
    [mailViewController setSubject:subject];

    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSString *currPlayformVersion = [CalculationHelper platformString];
    [mailViewController setMessageBody:[NSString stringWithFormat:@"iOS Version : %@\nDevice Model : %@",currSysVer,currPlayformVersion] isHTML:NO];

    TheRestaurantAppDelegate *theRestaurantAppDelegate = (TheRestaurantAppDelegate *)[[UIApplication sharedApplication] delegate];
    [theRestaurantAppDelegate.rootController presentModalViewController:mailViewController animated:YES];
    [[[[mailViewController viewControllers] lastObject] navigationItem] setTitle:title];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

@end
