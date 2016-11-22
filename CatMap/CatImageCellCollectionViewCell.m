//
//  CatImageCellCollectionViewCell.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "CatImageCellCollectionViewCell.h"
#import "DownloadManager.h"

@interface CatImageCellCollectionViewCell ()

@property (nonatomic) DownloadManager *downloadManager;

@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catImageTitle;


@end


@implementation CatImageCellCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.downloadManager = [DownloadManager new];
}

-(void)setCatPicture:(CatPicture *)catPicture {
    _catPicture = catPicture;
    [self configureCell];
}

-(void)configureCell {
    self.catImageTitle.text = self.catPicture.pictureTitle;
    [self downloadImage];
}

-(void)downloadImage {
    self.catImageView.image = nil;
    NSURL *tempPicURL = self.catPicture.imageUrl;
    [self.downloadManager getImage:self.catPicture.imageUrl completion:^(UIImage *image) {
        if ([self.catPicture.imageUrl isEqual:tempPicURL]) {
            self.catImageView.image = image;
            self.catImageView.contentMode = UIViewContentModeScaleAspectFit;
        }
    }];
}



@end
