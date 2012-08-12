//
//  XMLParser.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/30/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "XMLParser.h"
#import "XMLElement.h"

@implementation XMLParser

@synthesize xmlParser;
@synthesize rootElement;
@synthesize currentElementPointer;
@synthesize loginResult;
@synthesize dealListArray;
@synthesize currentTag;
@synthesize dealTagStatus;
@synthesize dealItem;
@synthesize dealComments;
@synthesize favoriteResult;
@synthesize registerResult;

- (XMLParser *)initXMLParser:(NSData*)data {

    self = [super init];

    commentCount = 0;

    xmlParser = [[NSXMLParser alloc] initWithData:data];
    self.xmlParser.delegate = self;

    if ([self.xmlParser parse])
    {
        NSLog(@"THE XML IS PARSED.");
    }
    else
    {
        NSError *error = [xmlParser parserError];
        NSLog(@"Error: %@", error);
        NSLog(@"PARSING FAIL");
    }

    return self;
}

#pragma mark Delegate Calls
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.rootElement = nil;
    self.currentElementPointer = nil;
}

-(void) parser:(NSXMLParser*)parser
        didStartElement:(NSString*)elementName
           namespaceURI:(NSString *)namespaceURI
          qualifiedName:(NSString *)qName
             attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"loginresult"])
    {
        if (!loginResult)
        {
            loginResult = [[NSMutableDictionary alloc] init];
            dealTagStatus = @"Login info began";
        }
    }
    else if ([dealTagStatus isEqualToString:@"Login info began"])
    {
        currentTag = elementName;
    }
    else if ([elementName isEqualToString:@"registerresult"])
    {
        if (!registerResult)
        {
            registerResult = [[NSMutableDictionary alloc] init];
        }
    }
    else if ([elementName isEqualToString:@"deals"])
    {
        if (!dealListArray)
        {
            dealListArray = [[NSMutableArray alloc] init];
        }
    }
    else  if ([elementName isEqualToString:@"deal"])
    {
        dealTagStatus = @"Deal info began";
        dealItem = [[NSMutableDictionary alloc] init];
    }
    else  if ([elementName isEqualToString:@"dealdetail"])
    {
        dealItem = [[NSMutableDictionary alloc] init];
        dealComments = [[NSMutableArray alloc] init];
        dealTagStatus = @"Deal detail began";
    }
    else  if ([elementName isEqualToString:@"comment"])
    {
        dealTagStatus = @"Deal comments began";
    }
    else  if ([elementName isEqualToString:@"updatefav"])
    {
        dealTagStatus = @"Updatefav began";
        favoriteResult = [[NSMutableDictionary alloc] init];
    }
    else if ([dealTagStatus isEqualToString:@"Deal detail began"])
    {
        currentTag = elementName;
    }
    else if ([dealTagStatus isEqualToString:@"Deal comments began"])
    {
        currentTag = elementName;
    }
    else if ( [dealTagStatus isEqualToString:@"Deal info began"] )
    {
        currentTag = elementName;
    }

//    root element DNE, create and point to it
    if (self.rootElement == nil)
    {
        self.rootElement = [[XMLElement alloc] init];
        self.currentElementPointer = self.rootElement;
    }
//            else root already exists
    else
    {
        XMLElement* newElement = [[XMLElement alloc] init];
        newElement.parent = self.currentElementPointer;
        [self.currentElementPointer.subElements addObject:newElement];
        self.currentElementPointer = newElement;
    }
    self.currentElementPointer.name = elementName;
    self.currentElementPointer.attributes = attributeDict;
}

-(void) parser:(NSXMLParser *)parser
        foundCharacters:(NSString *)string
{
    if ([self.currentElementPointer.text length] > 0)
    {
        self.currentElementPointer.text = [self.currentElementPointer.text stringByAppendingString:string];
    }
    else
    {
        self.currentElementPointer.text = string;
        //add result for login
        if ([dealTagStatus isEqualToString:@"Login info began"] && currentTag!= NULL)
        {
            [loginResult setObject:string forKey:currentTag];
            //[loginArray addObject:loginResult];

        }
        else if (registerResult)
        {
            [registerResult setObject:string forKey:@"registerresult"];
        }
                //add item to favorite result (might change to user-func result
        else if (favoriteResult)
        {
            [favoriteResult setObject:string forKey:@"updatefav"];
        }
                //Add deal list items to dictionary
        else if ([dealTagStatus isEqualToString:@"Deal info began"] && currentTag != NULL && ![string isEqualToString:@"\n"] &&![string isEqualToString:@""] )
        {

            [dealItem setObject:string forKey:currentTag];
        }
                //add deal detail items to dictionary
        else if ([dealTagStatus isEqualToString:@"Deal detail began"]
                && currentTag != NULL
                && ![string isEqualToString:@""])
        {
            [dealItem setObject:string forKey:currentTag];

        }
                //add comments to array
        else if ([dealTagStatus isEqualToString:@"Deal comments began"]
                && currentTag != NULL
                && ![string isEqualToString:@""])
        {
            [dealComments insertObject:string atIndex:commentCount];
            commentCount++;
        }
    }
}

//called when reaches end of an element
-(void)     parser:(NSXMLParser*)parser
     didEndElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
{
    self.currentElementPointer = self.currentElementPointer.parent;

    if ([elementName isEqualToString:@"deal"])
    {
        //add deal to dictionary
        [dealListArray addObject:dealItem];
    }

    if ([elementName isEqualToString:@"comments"])
    {
        dealTagStatus = @"Deal detail began";
    }
    if ([elementName isEqualToString:@"deals"]
            || [elementName isEqualToString:@"dealdetail"] )
    {
        dealTagStatus = @"Deals ended";
    }
}

//dispose of currentelemntpointer cuz document ended
-(void)parserDidEndDocument:(NSXMLParser *)parser {

    self.currentElementPointer = nil;
}

@end
