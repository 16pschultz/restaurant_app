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

@interface MainMenu ()

@end

#define TAG_LOGIN 1

@implementation MainMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationArray = [[NSMutableArray alloc] init];
    self.restaurantObjects = [[NSMutableArray alloc] init];
    self.distancesArray = [[NSMutableArray alloc] init];
    self.resAddressArray = [[NSMutableArray alloc] init];
    
    self.restaurantColView.delegate = self;
    self.restaurantColView.dataSource = self;
    
    [self queryForRestaurantData];
    [self addingLocations];
//    [self nearestRestaurant];
    [self sortArrays];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:)
                forControlEvents:UIControlEventValueChanged];
    [self.restaurantColView addSubview:refreshControl];
    [refreshControl setTintColor:[UIColor whiteColor]];
    self.restaurantColView.alwaysBounceVertical = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController.navigationBar setHidden:YES];

    if ([PFUser currentUser]) {
        
        [self.outletSignInButton setHidden:YES];
        [self.outletSignOutButton setHidden:NO];
        
    } else if (![PFUser currentUser]) {
        
        [self.outletSignInButton setHidden:NO];
        [self.outletSignOutButton setHidden:YES];
    }
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.restaurantObjects count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantCell" forIndexPath:indexPath];
        
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 7;
    
     [self sortArrays];
    cell.labelForRestaurant.text = [self.restaurantObjects objectAtIndex:indexPath.row][@"name"];
    
    PFFile *resLogo = [self.restaurantObjects objectAtIndex:indexPath.row][@"logo"];
    [resLogo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.restaurantImage.image = [UIImage imageWithData:imageData];
        }
    }];

    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(150.0, 150.0);
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
        
        PFFile *resLogo = [self.restaurantObjects objectAtIndex:indexPath.row][@"logo"];
        [resLogo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                viewC.picData = imageData;
            }
        }];
        
        viewC.resDealsUsed = [self.restaurantObjects objectAtIndex:indexPath.row][@"dealsUsed"];
        viewC.resObjectId =  [[self.restaurantObjects objectAtIndex:indexPath.row]objectId];
        viewC.resName =      [self.restaurantObjects objectAtIndex:indexPath.row][@"name"];
        viewC.resLocation =  [self.restaurantObjects objectAtIndex:indexPath.row][@"resLocation"];
        viewC.resLongitude = [self.restaurantObjects objectAtIndex:indexPath.row][@"longitude"];
        viewC.resLatitude =  [self.restaurantObjects objectAtIndex:indexPath.row][@"latitude"];
        viewC.resPhoneNum =  [self.restaurantObjects objectAtIndex:indexPath.row][@"phoneNum"];
        viewC.stringColor =  [self.restaurantObjects objectAtIndex:indexPath.row][@"color"];
        viewC.colorShade =   [self.restaurantObjects objectAtIndex:indexPath.row][@"colorShade"];
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

- (IBAction)SignOutButton {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    
    alertView.tag = TAG_LOGIN;
    [alertView show];
    
}


- (IBAction)SignInButton {
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    
}


- (void) queryForRestaurantData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (NSObject *resObj in objects) {
            NSLog(@"%@", resObj);
            [self.restaurantObjects addObject:resObj];
        }
        
        // Adding addresses to array
        for (int i = 0; i < self.restaurantObjects.count; i++) {
            NSString *address = [[self.restaurantObjects objectAtIndex:i] objectForKey:@"address"];
            [self.resAddressArray addObject:address];
            NSLog(@"%@", address);
        }
        [self.restaurantColView reloadData];
    }];
}


- (void) addingLocations {
    
    NSString *userAddress = @"1402 Forest Glen Court, Catonsville, Maryland";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:userAddress completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Processing the placemark
            NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
            NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
            
            CGFloat lat = latDest1.floatValue;
            CGFloat longtd = lngDest1.floatValue;
            
            self.userLocation = [[CLLocation alloc] initWithLatitude:lat longitude:longtd];
        }
    }];
    
    
    NSArray *addressArray = @[@"1402 Forest Glen Court, Catonsville, Maryland", @"6480 Dobbin Center Way, Columbia, Maryland", @"829 Frederick Rd, Catonsville, Maryland", @"805 Frederick Rd, Catonsville, Maryland"];
    
    // self.resAddressArray
    for (NSString *address in addressArray) {
        
         CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                // Processing the placemark
                NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
                NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
                
                CGFloat lat = latDest1.floatValue;
                CGFloat longtd = lngDest1.floatValue;
                
                CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:longtd];
                
                [self.locationArray addObject:location];
                NSLog(@"%@", location);
            }
        }];
    }
    
    NSLog(@"%@", self.locationArray);
    
    if (self.locationArray.count > 0) {
        for (int i = 0; i < self.locationArray.count; i++) {
            
            CLLocationDistance distance = [self.userLocation distanceFromLocation:self.locationArray[i]];
            int a = (int)distance;
            NSLog(@"%i", a);
            [self.distancesArray addObject:[NSNumber numberWithInt:a]];
        }
    }
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
        
        NSLog(@"%@", self.restaurantObjects);
        for (int j = 0; j <= i; j++) {
            
            if (self.distancesArray[j+1] < self.distancesArray[j]) {
                NSLog(@"%@ is less than %@",self.distancesArray[j+1], self.distancesArray[j]);
                id temp = self.distancesArray[j];
                self.distancesArray[j] = self.distancesArray[j+1];
                self.distancesArray[j+1] = temp;
                // Sorting Restaurants by distance
                self.restaurantObjects[j] = self.restaurantObjects[j+1];
                self.restaurantObjects[j+1] = temp;
            }
        }
    }
    NSLog(@"%@", self.restaurantObjects);

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
