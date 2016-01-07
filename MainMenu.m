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

@interface MainMenu ()

@end

#define TAG_LOGIN 1

@implementation MainMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self queryForRestaurantData];
    [self nearestRestaurant];
    [self queryResLogos];
    
    self.restaurantColView.delegate = self;
    self.restaurantColView.dataSource = self;
    
    
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
    
    cell.labelForRestaurant.text = [self.restaurantObjects objectAtIndex:indexPath.row][@"name"];
    
    cell.restaurantImage.image = [UIImage imageWithData:self.picData];
    
/*
    cell.restaurantImage.image = [UIImage imageWithData:[self.restaurantLogoData objectAtIndex:indexPath.row]];
*/
    
//    cell.restaurantImage.image = [self.restaurantLogos objectAtIndex:indexPath.row];
    
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
        self.restaurantObjects = objects;
        
        [self.restaurantColView reloadData];
    }];
    
}

- (void) queryResLogos {
    
    PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];
    PFFile *resLogo = restaurant[@"logo"];
    [resLogo getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
//            [self.restaurantLogoData addObject:imageData];
            self.picData = imageData;

        } else if (error) {

        }
        [self.restaurantColView reloadData];
    }];
    
    

/*
    for (int i = 0; i < self.restaurantObjects.count; i++) {
        
        NSData *imageData = [[self.restaurantObjects objectAtIndex:i] objectForKey:@""];
        UIImage *resLogo = [UIImage imageWithData:imageData];
        
        [self.restaurantLogos addObject:resLogo];
        
        NSLog(@"Queried %d logos", i);
    }
 */
}


- (void) nearestRestaurant {
    
    
    NSArray *addressArray = @[@"805 Frederick Road, Baltimore, Maryland", @"726 Frederick Rd, Catonsville, Maryland", @"829 Frederick Rd, Catonsville, Maryland"];
    
    for (NSString *address in addressArray) {
        
        // Code found on StackOverFlow
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                // Process the placemark.
                NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
                NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
                
                double lat = latDest1.doubleValue;
                double longtd = lngDest1.doubleValue;
                CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:longtd];
                
                [self.locationArray addObject:location];

                NSLog(@"%@", self.locationArray);

//                NSLog(@"%@", latDest1);
//                NSLog(@"%@", lngDest1);
            }
            
            NSLog(@"%@", self.locationArray);

            
            CLLocationDistance distance = [[self.locationArray objectAtIndex:0] distanceFromLocation:[self.locationArray objectAtIndex:1]]; //CLLocationDistance is a double
            
//            NSLog(@"%f", distance);
        }];
    }
}




@end
