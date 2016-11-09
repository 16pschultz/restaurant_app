//
//  MainMenu.h
//  Restaurant App
//
//  Created by Peter Schultz on 11/11/15.
//  Copyright © 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MainMenu : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

// Locations
@property (strong, nonatomic) NSMutableArray *resAddressArray;
@property (strong, nonatomic) NSMutableArray *locationArray;
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) NSMutableArray *distancesArray;


@property (strong, nonatomic) IBOutlet MKMapView *mapView;




@property (strong, nonatomic) NSData *picData;

@property (strong, nonatomic) NSMutableArray *restaurantObjects;

@property (strong, nonatomic) NSArray *restaurantInfo;


@property NSUInteger *numOfAddresses;

@property (strong, nonatomic) IBOutlet UICollectionView *restaurantColView;

//@property (strong, nonatomic) IBOutlet UILabel *labelForRestaurant;

@property (strong, nonatomic) IBOutlet UIButton *outletSignInButton;

- (IBAction)SignInButton;


@end
