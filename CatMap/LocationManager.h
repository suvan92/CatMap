//
//  LocationManager.h
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatPicture.h"

@interface LocationManager : NSObject

-(void)getPictureLocationData:(NSNumber *)pictureId completion:(void (^)(CLLocationCoordinate2D coord))completion;

@end
