//
//  MapVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 8/5/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//


#import "MapVC.h"
#import <QuartzCore/QuartzCore.h>


@interface MapVC ()

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.oDirectionsButton layer] setBorderWidth:1.3f];
    [[self.oDirectionsButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [[self.myMapView layer] setBorderWidth:2.5f];
    [[self.myMapView layer] setBorderColor:[UIColor redColor].CGColor];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    self.myMapView.mapType = MKMapTypeStandard;
    
    MKCoordinateRegion region = { {0.0, 0.0} , { 0.0, 0.0} };
    
    region.center.latitude = 39.271866;
    region.center.longitude = -76.732559;
    region.span.latitudeDelta = 0.01f;
    region.span.longitudeDelta = 0.01f;
    [self.myMapView setRegion:region];
    
    
    MapPin *ann = [[MapPin alloc] init];
    ann.title = @"Cape Up Bar & Restaurant";
    ann.subtitle = @"Catonsville, MD";
    ann.coordinate = region.center;
    [self.myMapView addAnnotation:ann];
    [self.myMapView selectAnnotation:ann animated:YES];
    
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


- (IBAction)toHereDirections:(id)sender {
    
    NSString *urlString = @"http://maps.apple.com/maps?daddr=39.271866,-76.732559";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    
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
