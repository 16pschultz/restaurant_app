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

@property (nonatomic, retain) IBOutlet MKMapView *myMapView;

- (IBAction)toHere;



@property (weak, nonatomic) IBOutlet UIButton *oDirectionsButton;


@end