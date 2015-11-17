//
//  Article.m
//  RedditTop50
//
//  Created by Carlos Peralta on 16/11/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import "Article.h"

@implementation Article

-(NSString*)entryDateFormatedXAgoStyle{
    double unixTimeStamp = self.utcUnixTimeStampEntryDate;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    
    int seconds = -(int)[date timeIntervalSinceNow];
    int hours = seconds/3600;

    return [NSString stringWithFormat:@"%d hours ago",hours];
}


-(BOOL)haveThumbnail{
    return self.thumbnailURL.length > 5;
}


@end
