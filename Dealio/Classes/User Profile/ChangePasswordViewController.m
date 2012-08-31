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

@implementation ChangePasswordViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(IBAction)backgroundTapped:(id)sender
{
    [self.view removeFromSuperview];
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
}

- (IBAction)cancelTapped:(id)sender 
{
    [self.view removeFromSuperview];
}

- (IBAction)changePasswordOKTapped:(id)sender 
{
    [GRCustomSpinnerView.instance addSpinnerToView:self.view];
    //todo connect to server and try to change password
    
}

@end
