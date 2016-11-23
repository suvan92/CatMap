//
//  CatPicture.h
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CatPicture : NSObject <MKAnnotation>

@property (nonatomic, strong) NSString *pictureTitle;
@property (nonatomic, strong) NSNumber *pictureId;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString *)title pictureID:(NSNumber *)pictureId andUrl:(NSString *)url;

@end
