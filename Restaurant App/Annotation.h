//
//  Annotation.h
//  Restaurant App
//
//  Created by Peter Schultz on 10/9/16.
//  Copyright © 2016 Cape Up Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subTitle;



@end
