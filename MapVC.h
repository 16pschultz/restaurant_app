//
//  MapVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 8/5/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"

@interface MapVC : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSString *resObjectId;
@property (strong, nonatomic) NSString *resName;

@property (strong, nonatomic) UIColor  *resColor;
@property (strong, nonatomic) UIColor  *offSetColor;

@property (strong, nonatomic) NSNumber *resLongitude;
@property (strong, nonatomic) NSNumber *resLatitude;

@property (nonatomic, retain) IBOutlet MKMapView *myMapView;

- (IBAction)toHere;

@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;


@property (weak, nonatomic) IBOutlet UIButton *oDirectionsButton;


@end
