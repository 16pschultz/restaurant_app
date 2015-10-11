//
//  MapVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 8/5/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//


#import "MapVC.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>


@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *resDetails, NSError *error) {
        
        NSString *resTitle;
        resTitle = [resDetails objectForKey:@"restaurantName"];
        
        NSString *resLocation;
        resLocation = [resDetails objectForKey:@"restaurantLocation"];

        NSNumber *resLong;
        resLong = [resDetails objectForKey:@"longitude"];
        
        NSNumber *resLat;
        resLat = [resDetails objectForKey:@"latitude"];

        self.myMapView.mapType = MKMapTypeStandard;
        
        MKCoordinateRegion region = { {0.0, 0.0} , { 0.0, 0.0} };
        
        region.center.latitude = [resLat intValue];
        region.center.longitude = [resLong intValue];
        region.span.latitudeDelta = 0.01f;
        region.span.longitudeDelta = 0.01f;
        [self.myMapView setRegion:region];

        MapPin *ann = [[MapPin alloc] init];
        ann.title = resTitle;
        ann.subtitle = resLocation;
        ann.coordinate = region.center;
        [self.myMapView addAnnotation:ann];
        [self.myMapView selectAnnotation:ann animated:YES];
    }];
    
    [[self.oDirectionsButton layer] setBorderWidth:1.3f];
    [[self.oDirectionsButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.myMapView layer] setBorderWidth:2.5f];
    [[self.myMapView layer] setBorderColor:[UIColor redColor].CGColor];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:NO];
    // Navigation Bar Attibutes
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}


- (IBAction)toHere {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Launch Maps App?"
                                                    message:@"Directions requires Apple Maps"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
    // Cancel was Tapped
    }else{
        NSString *urlString = @"http://maps.apple.com/maps?daddr=39.271866,-76.732559";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

@end
