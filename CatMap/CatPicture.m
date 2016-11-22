//
//  CatPicture.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "CatPicture.h"

@implementation CatPicture

-(instancetype)initWithTitle:(NSString *)title andUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _pictureTitle = title;
        _imageUrl = [NSURL URLWithString:url];
    }
    return self;
}

@end
