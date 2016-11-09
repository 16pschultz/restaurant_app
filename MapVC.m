//
//  MapVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 8/5/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//


#import "MapVC.h"
#import "MapPin.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"

#define TOWSONLONG -76.607109
#define TOWSONLAT 39.393623

@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.hoursLabel.text = [NSString stringWithFormat:@"Mon-Fri\t\t10am-10pm\nSat\t\t9am-2am\nSun\t\t9am-10pm\n\nRemember, kids eat FREE!"];
    
    
    
    // Creating region
    MKCoordinateRegion myRegion;
    
    // Center
    CLLocationCoordinate2D center;
    center.latitude = self.resLatitude.doubleValue;
    center.longitude = self.resLongitude.doubleValue;
    
    // The Span
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    
    myRegion.center = center;
    myRegion.span = span;
    
    CLLocationCoordinate2D location;
    Annotation *myAnn = [[Annotation alloc]init];

    location.latitude = self.resLatitude.doubleValue;
    location.longitude = self.resLongitude.doubleValue;
    myAnn.coordinate = location;
    myAnn.title = self.resName;
    
    [self.myMapView setRegion:myRegion animated:YES];
    [self.myMapView addAnnotation:myAnn];
    [self.myMapView selectAnnotation:myAnn animated:YES];

    
    self.oDirectionsButton.backgroundColor = self.resColor;
    [[self.oDirectionsButton layer] setBorderWidth:2.5f];
    [[self.oDirectionsButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [self.oDirectionsButton setTitleColor:self.offSetColor forState:UIControlStateNormal];

    
    [[self.myMapView layer] setBorderWidth:2.5f];
    [[self.myMapView layer] setBorderColor:self.resColor.CGColor];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:NO];
    // Navigation Bar Attibutes
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = self.offSetColor;
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

        NSString* addr = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%@,%@,%@&saddr=Current Location&directionsmode=driving",@"1402 Forest Glen Ct.",@"Catonsville",@"Maryland"];
        NSURL* url = [[NSURL alloc] initWithString:[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [[UIApplication sharedApplication] openURL:url];
        
        
/*
        // Code found on StackOverFlow
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:@"1600 Pennsylvania Ave NW, Washington, DC" completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                // Process the placemark.
                NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
                NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
                NSLog(@"The Lat is %@", latDest1);
                NSLog(@"The Long is %@", lngDest1);
            }
        }];
*/
        
        
        
//        NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%@,%@", self.resLatitude,self.resLongitude];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        
    }
}

@end
