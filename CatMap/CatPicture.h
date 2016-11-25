//
//  CatPicture.h
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Realm.h>

@interface CatPicture : NSObject <MKAnnotation>

@property (nonatomic) NSString *pictureTitle;
@property (nonatomic) NSNumber *pictureId;
@property (nonatomic) NSURL *imageUrl;
@property (nonatomic) NSURL *sqUrl;
@property (nonatomic) CLLocationCoordinate2D coordinate;


- (instancetype)initWithTitle:(NSString *)title pictureID:(NSNumber *)pictureId Url:(NSString *)url andSQUrl:(NSString *)sqUrl;

@end
