//
//  CatPicture.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "CatPicture.h"

@implementation CatPicture

-(instancetype)initWithTitle:(NSString *)title pictureID:(NSNumber *)pictureId Url:(NSString *)url andSQUrl:(NSString *)sqUrl {
    self = [super init];
    if (self) {
        _pictureTitle = title;
        _pictureId = pictureId;
        _imageUrl = [NSURL URLWithString:url];
        _sqUrl = [NSURL URLWithString:sqUrl];
    }
    return self;
}

@end
