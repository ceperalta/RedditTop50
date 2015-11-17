//
//  TableViewCell.h
//  RedditTop50
//
//  Created by Carlos Peralta on 16/11/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageIM;

@end
