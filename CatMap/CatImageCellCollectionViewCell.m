//
//  CatImageCellCollectionViewCell.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "CatImageCellCollectionViewCell.h"

@interface CatImageCellCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catImageTitle;


@end


@implementation CatImageCellCollectionViewCell

-(void)setCatPicture:(CatPicture *)catPicture {
    _catPicture = catPicture;
    [self configureCell];
}



-(void)configureCell {
    self.catImageTitle.text = self.catPicture.pictureTitle;
}



@end
