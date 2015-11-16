//
//  Article.h
//  RedditTop50
//
//  Created by Carlos Peralta on 16/11/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *entryDateFormatedXAgoStyle;
@property (nonatomic,assign) double utcUnixTimeStampEntryDate;
@property (nonatomic,strong) NSString *thumbnailURL;
@property (nonatomic,assign) BOOL haveThumbnail;
@property (nonatomic,assign) double numbersOfComments;

@end
