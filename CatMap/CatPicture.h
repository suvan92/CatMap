//
//  CatPicture.h
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatPicture : NSObject

@property (nonatomic, strong) NSString *pictureTitle;
@property (nonatomic, strong) NSURL *imageUrl;

- (instancetype)initWithTitle:(NSString *)title andUrl:(NSString *)url;

@end
