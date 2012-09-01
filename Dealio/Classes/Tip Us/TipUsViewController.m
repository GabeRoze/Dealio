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

@implementation TipUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
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
        pickerDisplayCell.timeLabel.text = @"Open";

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
        pickerDisplayCell.timeLabel.text = @"Close";

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

//        addressTextFieldCell.addressTextField.userInteractionEnabled = NO;
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

        CLLocationCoordinate2D annotationCoord;

        annotationCoord.latitude = SearchLocation.instance.getCurrentLocation.latitude;
        annotationCoord.longitude = SearchLocation.instance.getCurrentLocation.longitude;

        [mapViewCell.mapView removeAnnotations:mapViewCell.mapView.annotations];

        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
//            annotationPoint.title = //text field title
//            annotationPoint.subtitle = [dealListData objectForKey:@"businessname"];
        //other text field title
        [mapViewCell.mapView addAnnotation:annotationPoint];

        MKCoordinateRegion zoomIn = mapViewCell.mapView.region;
        zoomIn.span.latitudeDelta = 0.01;
        zoomIn.span.longitudeDelta = 0.01;
        zoomIn.center.latitude = annotationCoord.latitude;
        zoomIn.center.longitude = annotationCoord.longitude;
        [mapViewCell.mapView setRegion:zoomIn animated:YES];
        [self performSelector:@selector(selectLastAnnotation:) withObject:mapViewCell.mapView afterDelay:1.0f];

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

        RIButtonItem *cancelButton = [RIButtonItem item];
        cancelButton.action = ^{
            //close the views
        };
        [cancelButton setLabel:@"Cancel"];

        RIButtonItem *selectButton = [RIButtonItem item];
        selectButton.action = ^{
            //close the views
            //use selected element in text field
        };
        selectButton.label = @"Select";

        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Open Time"
                                                         cancelButtonItem:cancelButton destructiveButtonItem:selectButton otherButtonItems:nil];

        UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 235, 320, 200)];
        myPickerView.delegate = self;
        myPickerView.showsSelectionIndicator = YES;
//        [self.view addSubview:myPickerView];

        [actionSheet addSubview:myPickerView];
        [self.view addSubview: actionSheet];
    }
    else if (indexPath.row == 7)
    {
        //same shit as row = 6
    }
    else if (indexPath.row == 8)
    {
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        TipUsAddressTextFieldCell *tipUsAddressTextFieldCell = (TipUsAddressTextFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        tipUsAddressTextFieldCell.addressTextField.becomeFirstResponder;
    }
    else if (indexPath.row == 11)
    {
        //todo - arrange all data
        //connect to web with data
    }

    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


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

-(void)selectLastAnnotation:(MKMapView *)mapView
{
    [mapView selectAnnotation:[mapView.annotations lastObject] animated:YES];
}
@end
