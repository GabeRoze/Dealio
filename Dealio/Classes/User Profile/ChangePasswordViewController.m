//
//  ChangePasswordViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "GRCustomSpinnerView.h"
#import "TextFieldCell.h"
#import "GRCustomSpinnerView.h"
#import "UIAlertView+Blocks.h"
#import "DealioService.h"
#import "XMLParser.h"

@implementation ChangePasswordViewController
@synthesize currentPasswordTextField;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [currentPasswordTextField becomeFirstResponder];
}

- (IBAction)currentPasswordEntered:(id)sender
{
    [newPasswordTextField becomeFirstResponder];
}

- (IBAction)newPasswordEntered:(id)sender
{
    [confirmNewPasswordTextfield becomeFirstResponder];
}

- (IBAction)confirmNewPasswordEntered:(id)sender
{
    [confirmNewPasswordTextfield resignFirstResponder];
    [self changePassword];
}

- (IBAction)cancelTapped:(id)sender
{
    [self fadeView];
}

- (IBAction)okTapped:(id)sender
{
    [self changePassword];
}

-(void)fadeView
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = self.view.frame.size.height;
        self.view.frame = frame;
        self.view.alpha = 0.0;
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
}

-(void)changePassword
{
    if  ([self verifyPasswords])
    {
        [GRCustomSpinnerView.instance addSpinnerToView:self.view];
        [DealioService changePasswordWithNewPassword:confirmNewPasswordTextfield.text currentPassword:currentPasswordTextField.text onSuccess:^(NSData *data){
            [GRCustomSpinnerView.instance stopSpinner];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                XMLParser *parser = [[XMLParser alloc] initXMLParser:data];
                NSString *messageText = [parser.userFunction objectForKey:@"message"];

                if ([messageText isEqualToString:@"success"])
                {
                    dispatch_async( dispatch_get_main_queue(), ^{
                        [GRCustomSpinnerView.instance stopSpinner];
                        currentPasswordTextField.text = @"";
                        newPasswordTextField.text = @"";
                        confirmNewPasswordTextfield.text = @"";
                        [self displayAlertWithButtonTitle:@"Paswword Successfully Changed!" andAction:^{
                            [self fadeView];
                        }];
                    });
                }
                else if ([messageText isEqualToString:@"fail"])
                {
                    dispatch_async( dispatch_get_main_queue(), ^{
                        [GRCustomSpinnerView.instance stopSpinner];
                        [self displayAlertWithButtonTitle:@"Current password is incorrect" andAction:^{
                            [currentPasswordTextField becomeFirstResponder];
                        }];
                    });
                }
            });
        }
                andFailure:^{
                    [GRCustomSpinnerView.instance stopSpinner];
                    [self displayAlertWithButtonTitle:@"Server error, try again later" andAction:^{
                    }];
                }];
    }
}

-(BOOL)verifyPasswords
{
    if (currentPasswordTextField.text.length < 1)
    {
        [self displayAlertWithButtonTitle:@"Please enter your current password" andAction:^{
            [currentPasswordTextField becomeFirstResponder];
        }];
        return NO;
    }
    else if (newPasswordTextField.text.length < 1)
    {
        [self displayAlertWithButtonTitle:@"Please enter a new password" andAction:^{
            [newPasswordTextField becomeFirstResponder];
        }];
        return NO;
    }
    else if (confirmNewPasswordTextfield.text.length < 1)
    {
        [self displayAlertWithButtonTitle:@"Please confirm your new password" andAction:^{
            [confirmNewPasswordTextfield becomeFirstResponder];
        }];
        return NO;
    }
    else if (![newPasswordTextField.text isEqualToString:confirmNewPasswordTextfield.text])
    {
        [self displayAlertWithButtonTitle:@"Passwords do not match" andAction:^{
            newPasswordTextField.text = @"";
            confirmNewPasswordTextfield.text = @"";
            [newPasswordTextField becomeFirstResponder];
        }];
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)displayAlertWithButtonTitle:(NSString *)title andAction:(void (^)())action
{
    RIButtonItem *buttonItem = [RIButtonItem new];
    buttonItem.label = @"OK";
    buttonItem.action = action;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:@"" cancelButtonItem:buttonItem otherButtonItems:nil];
    [alertView show];
}


- (void)viewDidUnload {
    [self setCurrentPasswordTextField:nil];
    [super viewDidUnload];
}
@end
