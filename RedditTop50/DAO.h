//
//  DAO.h
//  RedditTop50
//
//  Created by Carlos Peralta on 16/11/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ArticlesArriveProtocol <NSObject>
@required
- (void) articlesArrive:(NSArray *)articles;
@end

@interface DAO : NSObject

@property (weak,nonatomic) id<ArticlesArriveProtocol>daoDelegate;

-(void)getTop50;

@end
