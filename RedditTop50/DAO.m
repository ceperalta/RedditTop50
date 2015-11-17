//
//  DAO.m
//  RedditTop50
//
//  Created by Carlos Peralta on 16/11/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import "DAO.h"
#import "Article.h"




@interface DAO() <NSURLSessionDataDelegate>
@property (nonatomic,strong) NSMutableArray *articlesMD;
@property (nonatomic,strong) NSString *strUrlTop25;
@property (nonatomic,strong) NSURLSession *urlS;
@property (nonatomic,assign) int numberOfPagesFor50Top;
@end

@implementation DAO

-(void)getTop50{
    _articlesMD = [[NSMutableArray alloc] init];
    _strUrlTop25 = @"https://api.reddit.com/top.json";
    _urlS = [NSURLSession sharedSession];
    _numberOfPagesFor50Top = 2;
    [self recursiveUrlTask:_strUrlTop25];
}

- (void)recursiveUrlTask:(NSString*)strURL{
    [[_urlS dataTaskWithURL:[NSURL URLWithString:_strUrlTop25]
         completionHandler:^(NSData *data,
                             NSURLResponse *response,
                             NSError *error) {
             
             NSDictionary *responseD = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:nil];
             
             NSDictionary *articles = [[responseD objectForKey:@"data"] objectForKey:@"children"];
             
             for (NSDictionary *article in articles) {
                 NSDictionary *dataForArticleD = [article objectForKey:@"data"];
                 
                 Article *art = [[Article alloc] init];
                 art.title = [dataForArticleD objectForKey:@"title"];
                 art.author = [dataForArticleD objectForKey:@"author"];
                 art.utcUnixTimeStampEntryDate = [[dataForArticleD objectForKey:@"created_utc"] doubleValue];
                 art.thumbnailURL = [dataForArticleD objectForKey:@"thumbnail"];
                 art.numbersOfComments = [dataForArticleD objectForKey:@"num_comments"];
                 
                 if ([[dataForArticleD allKeys] containsObject:@"thumbnail"]) {
                     art.thumbnailURL = [dataForArticleD objectForKey:@"thumbnail"];
                     NSArray *previeImagesA = [[dataForArticleD objectForKey:@"preview"] objectForKey:@"images"];
                     art.fullSizeImageURL = [previeImagesA objectAtIndex:0];
                     [_articlesMD addObject:art];
                 }else{
                     art.thumbnailURL = @"";
                 }
                 
                 
             }
             
             _numberOfPagesFor50Top--;
             
             // When second page of tops is complete, then we return :)
             if (_numberOfPagesFor50Top==0) {
                 [self.daoDelegate articlesArrive:(NSArray*)_articlesMD];
             }else{
                 // We need to get the second page of tops
                 // data > "after"
                 NSString *strAfterPageCode = [[responseD objectForKey:@"data"] objectForKey:@"after"];
                 _strUrlTop25 = [NSString stringWithFormat:@"%@%@%@",_strUrlTop25,@"?count=25&after=", strAfterPageCode];
                 NSLog(@"nuevo url: %@",_strUrlTop25);
                 [self recursiveUrlTask:_strUrlTop25];
             }
         }] resume];
}


@end
