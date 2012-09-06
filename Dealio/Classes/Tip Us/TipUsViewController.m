//
//  TipUsViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "TipUsViewController.h"
#import "TableHeaderCell.h"
#import "TextFieldCell.h"
#import "TableFooterCell.h"
#import "TipUsAddressTextFieldCell.h"
#import "SelectDayCell.h"
#import "PickerDisplayCell.h"
#import "UIActionSheet+Blocks.h"
#import "MapViewCell.h"
#import "DealioService.h"
#import "ActionSheetPicker.h"
#import "Models.h"
#import "ButtonCell.h"
#import "AlertHelper.h"
#import "GRCustomSpinnerView.h"
#import "XMLParser.h"

@implementation TipUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TipUsData.instance;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellIdentifier";
    if (indexPath.row == 0)
    {
        CellTableIdentifier = @"TipUsHeaderCellIdentifier";
        TableHeaderCell *tipUsHeaderCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!tipUsHeaderCell)
        {
            tipUsHeaderCell = [TableHeaderCell new];
        }

        return tipUsHeaderCell;
    }

    else if (indexPath.row == 1)
    {
        CellTableIdentifier = @"TextFieldCellIdentifier";

        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!textFieldCell)
        {
            textFieldCell = [TextFieldCell new];
        }

        [textFieldCell.cellTextField setPlaceholder:@"Restaurant Name"];
        textFieldCell.cellType = RestaurantNameCell;

        return textFieldCell;
    }
    else if (indexPath.row == 2)
    {
        CellTableIdentifier = @"TextFieldCellIdentifier";

        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!textFieldCell)
        {
            textFieldCell = [TextFieldCell new];
        }

        textFieldCell.cellTextField.placeholder = @"What's the Dealio?";
        textFieldCell.cellType = DealNameCell;

        return textFieldCell;
    }
    else if (indexPath.row == 3)
    {
        CellTableIdentifier = @"TextFieldCellIdentifier";

        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!textFieldCell)
        {
            textFieldCell = [TextFieldCell new];
        }

        textFieldCell.cellTextField.placeholder = @"A little detail about the deal";
        textFieldCell.cellType = DealDetailCell;

        return textFieldCell;
    }
    else if (indexPath.row == 4)
    {
        CellTableIdentifier = @"TableFooterCell";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_tan_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 5)
    {
        CellTableIdentifier = @"SelectDayCellIdentifier";

        SelectDayCell *selectDayCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!selectDayCell)
        {
            selectDayCell = [SelectDayCell new];
        }

        return  selectDayCell;
    }
    else if (indexPath.row == 6)
    {
        CellTableIdentifier = @"PickerDisplayCellIdentifier";

        PickerDisplayCell *pickerDisplayCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!pickerDisplayCell)
        {
            pickerDisplayCell = [PickerDisplayCell new];
        }

        pickerDisplayCell.descriptionLabel.text = @"From";

        if (pickerDisplayCell.timeLabel.text.length < 1)
        {
            pickerDisplayCell.timeLabel.text = @"Select Open Time";
        }

        return  pickerDisplayCell;
    }
    else if (indexPath.row == 7)
    {
        CellTableIdentifier = @"PickerDisplayCellIdentifier";

        PickerDisplayCell *pickerDisplayCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!pickerDisplayCell)
        {
            pickerDisplayCell = [PickerDisplayCell new];
        }

        pickerDisplayCell.descriptionLabel.text = @"To";

        if (pickerDisplayCell.timeLabel.text.length < 1)
        {
            pickerDisplayCell.timeLabel.text = @"Select Close Time";
        }

        return  pickerDisplayCell;
    }
    else if (indexPath.row == 8)
    {
        CellTableIdentifier = @"TableFooterCell";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_tan_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 9)
    {
        CellTableIdentifier = @"TipUsAddressTextFieldIdentifier";

        TipUsAddressTextFieldCell *addressTextFieldCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!addressTextFieldCell)
        {
            addressTextFieldCell = [TipUsAddressTextFieldCell new];
        }

        [addressTextFieldCell.addressTextField addTarget:self action:@selector(addressDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];

//        addressTextFieldCell.addressTextField
        //todo -address text field cell changed - update the map;

        return  addressTextFieldCell;
    }
    else if (indexPath.row == 10)
    {
        CellTableIdentifier = @"MapViewCellIdentifier";

        MapViewCell *mapViewCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!mapViewCell)
        {
            mapViewCell = [MapViewCell new];
        }


        TipUsAddressTextFieldCell *tipUsAddressTextFieldCell = (TipUsAddressTextFieldCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];

        if (tipUsAddressTextFieldCell.addressTextField.text.length < 1)
        {

            CLLocationCoordinate2D annotationCoord;

            annotationCoord.latitude = SearchLocation.instance.getCurrentLocation.latitude;
            annotationCoord.longitude = SearchLocation.instance.getCurrentLocation.longitude;

            [mapViewCell.mapView removeAnnotations:mapViewCell.mapView.annotations];

            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = annotationCoord;
            [mapViewCell.mapView addAnnotation:annotationPoint];

            MKCoordinateRegion zoomIn = mapViewCell.mapView.region;
            zoomIn.span.latitudeDelta = 0.01;
            zoomIn.span.longitudeDelta = 0.01;
            zoomIn.center.latitude = annotationCoord.latitude;
            zoomIn.center.longitude = annotationCoord.longitude;
            [mapViewCell.mapView setRegion:zoomIn animated:YES];

            [mapViewCell.mapView setShowsUserLocation:NO];

            TipUsData.instance.longitude = [NSString stringWithFormat:@"%f", annotationCoord.longitude];
            TipUsData.instance.latitude = [NSString stringWithFormat:@"%f", annotationCoord.latitude];
            //set address

            [self performSelector:@selector(selectLastAnnotation:) withObject:mapViewCell.mapView afterDelay:1.0f];
        }


        return mapViewCell;
    }
    else if (indexPath.row == 11)
    {
        UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!tableViewCell)
        {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
        }
        tableViewCell.textLabel.text = @"Submit";
        tableViewCell.textLabel.textAlignment = UITextAlignmentCenter;

        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
        [tableViewCell addSubview:backgroundImage];

        return tableViewCell;
    }
    else if (indexPath.row == 12)
    {
        CellTableIdentifier = @"ButtonCellIdentifier";

        ButtonCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!buttonCell)
        {
            buttonCell = [ButtonCell new];
        }

        buttonCell.buttonLabel.text = @"Submit";

        return buttonCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row >= 0 && indexPath.row <= 3) || (indexPath.row >= 6 && indexPath.row <= 7) || indexPath.row == 9 || indexPath.row == 11)
    {
        return 44;
    }
    else if (indexPath.row == 4 || indexPath.row == 8)
    {
        return 20;
    }
    else if (indexPath.row == 5)
    {
        return 60;
    }
    else if (indexPath.row == 10)
    {
        return 240;
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 1 && indexPath.row <= 3)
    {
        TextFieldCell *textFieldCell = (TextFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        textFieldCell.cellTextField.becomeFirstResponder;
    }
    else if (indexPath.row == 6)
    {
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
        {
            PickerDisplayCell *pickerDisplayCell = (PickerDisplayCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
            pickerDisplayCell.timeLabel.text = selectedValue;
            TipUsData.instance.openTime = selectedIndex;
        };
        NSArray *times = [NSArray arrayWithObjects:@"Open", @"8 am", @"9 am", @"10 am", @"11 am", @"12 pm", @"1 pm", @"2 pm", @"3 pm", @"4 pm", @"5 pm", @"6 pm", @"7 pm", @"8 pm", @"9 pm", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select Open Time" rows:times initialSelection:0 doneBlock:done cancelBlock:nil origin:self.view];

    }
    else if (indexPath.row == 7)
    {
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
        {
            PickerDisplayCell *pickerDisplayCell = (PickerDisplayCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
            pickerDisplayCell.timeLabel.text = selectedValue;
            TipUsData.instance.closeTime = selectedIndex;
        };
        NSArray *times = [NSArray arrayWithObjects:@"10 am", @"11 am", @"12 pm", @"1 pm", @"2 pm", @"3 pm", @"4 pm", @"5 pm", @"6 pm", @"7 pm", @"8 pm", @"9 pm", @"10 pm", @"Close", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select Open Time" rows:times initialSelection:0 doneBlock:done cancelBlock:nil origin:self.view];    }
    else if (indexPath.row == 9)
    {
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        TipUsAddressTextFieldCell *tipUsAddressTextFieldCell = (TipUsAddressTextFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        [tipUsAddressTextFieldCell.addressTextField becomeFirstResponder];
    }
    else if (indexPath.row == 12)
    {
        if ([self validateTipUsData])
        {
            [GRCustomSpinnerView.instance addSpinnerToView:self.view];

            self.navigationController.navigationBarHidden = YES;
            [DealioService getUserProfileWithSuccess:^(NSData *data){

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    XMLParser *parser = [[XMLParser alloc] initXMLParser:data];
                    NSLog(@"parser data %@",parser.userFunction);
                    NSString *messageText = [parser.userFunction objectForKey:@"message"];

                    dispatch_async( dispatch_get_main_queue(), ^{
                        [GRCustomSpinnerView.instance stopSpinner];

                        if ([messageText isEqualToString:@"emailsuccess"])
                        {
                            [AlertHelper displayAlertWithOKButtonUsingTitle:@"Tip Sent!" withMessage:@"WE WILL DOS TUFF LATERSSS" andAction:^{
                                [self dismissModalViewControllerAnimated:YES];
                            }];
                        }
                        else if ([messageText isEqualToString:@"emailfail"])
                        {
                            //todo - when does this occur
                        }

                    });
                });
            }
                                          andFailure:^{
                                              [GRCustomSpinnerView.instance stopSpinner];
                                              [AlertHelper displayWebConnectionFail];
                                          }];


        }


    }

    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/*
#pragma mark - Picker View Data Source and Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return 3;
    }
    else if (component == 1)
    {
        return 12;
    }
    else if (component == 2)
    {
        return 13;
    }
    else if (component == 3)
    {
        return 2;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0)
    {
        return 50;
    }
    else if (component == 1)
    {
        return 50;
    }
    else if (component == 2)
    {
        return 50;
    }
    else if (component == 3)
    {
        return 50;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        if (row == 0)
        {
            return @"Open";
        }
        else if (row == 1)
        {
            return @"Close";
        }
        else if (row == 2)
        {
            return @"Time";
        }
    }
    else if (component == 1)
    {
        return [NSString stringWithFormat:@"%i", row+1];
    }
    else if (component == 2)
    {
        return [NSString stringWithFormat:@"%i", row*5];
    }
    else if (component == 3)
    {
        if (row == 0)
        {
            return @"AM";
        }
        else if (row == 1)
        {
            return @"PM";
        }
    }
}
*/
-(void)selectLastAnnotation:(MKMapView *)mapView
{
    [mapView selectAnnotation:[mapView.annotations objectAtIndex:0] animated:YES];
}

-(void)addressDidBeginEditing:(id)sender
{
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(BOOL)validateTipUsData
{
    if (TipUsData.instance.businessName.length < 1)
    {
        TextFieldCell *textFieldCell = (TextFieldCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [AlertHelper displayAlertWithOKButtonUsingTitle:@"Enter Restaurant Name" andAction:^{
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [textFieldCell.cellTextField becomeFirstResponder];
        }];
        return NO;
    }
    else if (TipUsData.instance.dealName.length < 1)
    {
        TextFieldCell *textFieldCell = (TextFieldCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        [AlertHelper displayAlertWithOKButtonUsingTitle:@"Enter Deal Name" andAction:^{
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [textFieldCell.cellTextField becomeFirstResponder];
        }];
        return NO;
    }
    else if (TipUsData.instance.detail.length < 1)
    {
        TextFieldCell *textFieldCell = (TextFieldCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [AlertHelper displayAlertWithOKButtonUsingTitle:@"Enter Deal Description" andAction:^{
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            [textFieldCell.cellTextField becomeFirstResponder];
        }];
        return NO;
    }

    int sum = 0;
    for (NSUInteger i = 0; i < TipUsData.instance.days.count; i++)
    {
        sum += [[TipUsData.instance.days objectAtIndex:i] intValue];
    }

    if (sum > 0)
    {
        [AlertHelper displayAlertWithOKButtonUsingTitle:@"What day does this deal happen?" andAction:^{
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
        return NO;
    }
    else if (TipUsData.instance.openTime < 0)
    {
        [AlertHelper displayAlertWithOKButtonUsingTitle:@"Select Open Time" andAction:^{
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
        return NO;
    }
    else if (TipUsData.instance.closeTime < 0)
    {
        [AlertHelper displayAlertWithOKButtonUsingTitle:@"Select Close Time" andAction:^{
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
        return NO;
    }

    return YES;
}

@end
