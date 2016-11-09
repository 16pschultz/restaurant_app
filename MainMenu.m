//
//  MainMenu.m
//  Restaurant App
//
//  Created by Peter Schultz on 11/11/15.
//  Copyright © 2015 Cape Up Development. All rights reserved.
//

#import <Parse/Parse.h>

#import "MainMenu.h"
#import "RestaurantViewCell.h"
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "Annotation.h"

@interface MainMenu ()

@end

#define TAG_LOGIN 1

// Towson Coordinates
#define TOWSONLONG -76.607109
#define TOWSONLAT 39.393623

// Span

#define THESPAN 0.025F


@implementation MainMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationArray = [[NSMutableArray alloc] init];
    self.restaurantInfo = [[NSMutableArray alloc] init];
    self.distancesArray = [[NSMutableArray alloc] init];
    self.resAddressArray = [[NSMutableArray alloc] init];
    
    self.restaurantColView.delegate = self;
    self.restaurantColView.dataSource = self;
    
//    [self addingLocations];
//    [self nearestRestaurant];
//    [self sortArrays];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:)
                forControlEvents:UIControlEventValueChanged];
    [self.restaurantColView addSubview:refreshControl];
    [refreshControl setTintColor:[UIColor whiteColor]];
    self.restaurantColView.alwaysBounceVertical = YES;
    
    [self queryForRestaurantData];

//    [self settingMapView];
    
    [self.restaurantColView reloadData];
    
    /*
    CLLocationCoordinate2D towsonLocation;
    towsonLocation.latitude = TOWSONLAT;
    towsonLocation.longitude = TOWSONLONG;
    
    Annotation *myAnnotation = [Annotation alloc];
    myAnnotation.coordinate = towsonLocation;
    myAnnotation.title = @"Towson University";
    myAnnotation.subTitle = @"Home of the Tigers";
    
    [self.mapView addAnnotation:myAnnotation];
    [self.mapView selectAnnotation:myAnnotation animated:YES];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController.navigationBar setHidden:YES];

    if ([PFUser currentUser]) {
        
//        [self.outletSignInButton setHidden:YES];
//        [self.outletSignOutButton setHidden:NO];
        
    } else if (![PFUser currentUser]) {
        
//        [self.outletSignInButton setHidden:NO];
//        [self.outletSignOutButton setHidden:YES];
    }
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.restaurantInfo count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantCell" forIndexPath:indexPath];
        
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 7;
    
     [self sortArrays];
    cell.labelForRestaurant.text = [self.restaurantInfo objectAtIndex:indexPath.row][@"name"];
    
    PFFile *resLogo = [self.restaurantInfo objectAtIndex:indexPath.row][@"logo"];
    [resLogo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.restaurantImage.image = [UIImage imageWithData:imageData];
        }
    }];

    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(95.0, 95.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"showRestaurant" sender:indexPath];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showRestaurant"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        ViewController *viewC = (ViewController *)segue.destinationViewController;
        
        PFFile *resLogo = [self.restaurantInfo objectAtIndex:indexPath.row][@"logo"];
        [resLogo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                viewC.picData = imageData;
            }
        }];

        
        viewC.resDealsUsed = [self.restaurantInfo objectAtIndex:indexPath.row][@"dealsUsed"];
        viewC.resObjectId =  [[self.restaurantInfo objectAtIndex:indexPath.row]objectId];
        viewC.resName =      [self.restaurantInfo objectAtIndex:indexPath.row][@"name"];
        viewC.resLocation =  [self.restaurantInfo objectAtIndex:indexPath.row][@"resLocation"];
        viewC.resLongitude = [[self.restaurantInfo objectAtIndex:indexPath.row] objectForKey:@"longitude"];
        viewC.resLatitude =  [[self.restaurantInfo objectAtIndex:indexPath.row] objectForKey:@"latitude"];
        viewC.resPhoneNum =  [self.restaurantInfo objectAtIndex:indexPath.row][@"phoneNum"];
        viewC.stringColor =  [self.restaurantInfo objectAtIndex:indexPath.row][@"color"];
        viewC.colorShade =   [self.restaurantInfo objectAtIndex:indexPath.row][@"colorShade"];
    }
}

-(void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:[[PFUser currentUser]objectId] block:^(PFObject *resNum, NSError *error) {
        
        
        if (alertView.cancelButtonIndex == buttonIndex){
            // Do cancel
            
        } else if (alertView.tag == TAG_LOGIN){
            [PFUser logOut];
            [self performSegueWithIdentifier:@"showLogin" sender:self];
        }
    }];
}


- (IBAction)SignInButton {
    
    // If user is signed in
    if ([PFUser currentUser]) {
   
    } else {
        
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}


- (void) queryForRestaurantData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        self.restaurantInfo = objects;
        
//        for (NSObject *resObj in objects) {
//            NSLog(@"%@", resObj);
//            [self.restaurantInfo addObject:resObj];
//        }
        
        [self addAnnotations];

//        [self.restaurantColView reloadData];
    }];
}


- (void) settingMapView {
    
    NSArray *addressArray = @[@"408 York Rd, Towson, MD 21286", @"7800 York Rd Towson, MD  21204 United States"];
    
    NSMutableArray *locationsArray = [[NSMutableArray alloc] init];
    
    for (NSString *address in addressArray) {
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                Annotation *myAnn = [[Annotation alloc] init];

                double latitude = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude].doubleValue;
                double longitude = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude].doubleValue;
                
                CLLocationCoordinate2D location;
                location.latitude = latitude;
                location.longitude = longitude;

                myAnn.coordinate = location;
                
                [locationsArray addObject:myAnn];
            }
        }];
    }
    
    
    //    NSMutableArray *locations = [[NSMutableArray alloc] init];
    //    CLLocationCoordinate2D location;
    //    Annotation *myAnn;
    //
    //    // Bill Bateman's Annotation
    //    myAnn = [[Annotation alloc]init];
    //    location.latitude = BILLBATE_LAT;
    //    location.longitude = BILLBATE_LONG;
    //    myAnn.coordinate = location;
    //    myAnn.title = @"Bill Bateman's";
    //    [locations addObject:myAnn];
    
    
    // Creating region
    MKCoordinateRegion myRegion;
    
    // Center
    CLLocationCoordinate2D center;
    center.latitude = TOWSONLAT;
    center.longitude = TOWSONLONG;
    
    // The Span
    MKCoordinateSpan span;
    span.latitudeDelta = THESPAN;
    span.longitudeDelta = THESPAN;
    
    myRegion.center = center;
    myRegion.span = span;
    
    [self.mapView setRegion:myRegion animated:YES];
    
    [self.mapView addAnnotations:locationsArray];
    
    
    
    
    
//    NSLog(@"%@", self.locationArray);
//    
//    if (self.locationArray.count > 0) {
//        for (int i = 0; i < self.locationArray.count; i++) {
//            
//            CLLocationDistance distance = [self.userLocation distanceFromLocation:self.locationArray[i]];
//            int a = (int)distance;
//            NSLog(@"%i", a);
//            [self.distancesArray addObject:[NSNumber numberWithInt:a]];
//        }
//    }
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *myPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"hl"];

    myPin.pinColor = MKPinAnnotationColorPurple;
    
    return myPin;
}

- (void) addAnnotations {
    
    // Creating region
    MKCoordinateRegion myRegion;
    
    // Center
    CLLocationCoordinate2D center;
    center.latitude = TOWSONLAT;
    center.longitude = TOWSONLONG;
    
    // The Span
    MKCoordinateSpan span;
    span.latitudeDelta = THESPAN;
    span.longitudeDelta = THESPAN;
    
    myRegion.center = center;
    myRegion.span = span;
    
    [self.mapView setRegion:myRegion animated:YES];
    
    
    // Annotation
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    CLLocationCoordinate2D location;
    Annotation *myAnn;
    
    
    for (int i = 0; i < [self.restaurantInfo count]; i++) {
        
        myAnn = [[Annotation alloc]init];
        double latitude = [NSString stringWithFormat:@"%@",[[self.restaurantInfo objectAtIndex:i] objectForKey:@"latitude"]].doubleValue;
        double longitude = [NSString stringWithFormat:@"%@",[[self.restaurantInfo objectAtIndex:i] objectForKey:@"longitude"]].doubleValue;
        location.latitude = latitude;
        location.longitude = longitude;
        myAnn.coordinate = location;
        myAnn.title = [[self.restaurantInfo objectAtIndex:i] objectForKey:@"name"];
        [locations addObject:myAnn];
    }
    
    

//    // Towson's Annotation
//    myAnn = [[Annotation alloc]init];
//    location.latitude = TOWSONLAT;
//    location.longitude = TOWSONLONG;
//    myAnn.coordinate = location;
//    myAnn.title = @"Towson University";
//    [locations addObject:myAnn];
    
    [self.mapView addAnnotations:locations];
//    [self.mapView selectAnnotation:myAnn animated:YES];
    [self.restaurantColView reloadData];
}

- (void) nearestRestaurant {
    
    NSLog(@"%@", self.locationArray);
    
    for (int i = 0; i < self.locationArray.count; i++) {
        
        CLLocationDistance distance = [self.userLocation distanceFromLocation:self.locationArray[i]];
        int a = (int)distance;
        NSLog(@"%i", a);
        [self.distancesArray addObject:[NSNumber numberWithInt:a]];
    }
}

- (void) sortArrays {
    
    NSLog(@"%@", self.distancesArray);
    
    for (int i = self.distancesArray.count-2; i >= 0; i--) {
        NSLog(@"%i", i);
        NSLog(@"%@", [self.distancesArray objectAtIndex:i]);
        NSLog(@"%@", self.distancesArray);
        
        NSLog(@"%@", self.restaurantInfo);
        for (int j = 0; j <= i; j++) {
            
            if (self.distancesArray[j+1] < self.distancesArray[j]) {
                NSLog(@"%@ is less than %@",self.distancesArray[j+1], self.distancesArray[j]);
                id temp = self.distancesArray[j];
                self.distancesArray[j] = self.distancesArray[j+1];
                self.distancesArray[j+1] = temp;
                // Sorting Restaurants by distance
//                self.restaurantInfo[j] = self.restaurantInfo[j+1];
//                self.restaurantInfo[j+1] = temp;
            }
        }
    }
    NSLog(@"%@", self.restaurantInfo);

    for (int i = 0; i < self.distancesArray.count; i++) {
        
         NSLog(@"%@", self.distancesArray[i]);
    }
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    
    [self queryForRestaurantData];
    [self.restaurantColView reloadData];
    [refreshControl endRefreshing];
}

@end
