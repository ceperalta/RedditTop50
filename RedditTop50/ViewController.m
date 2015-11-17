//
//  TableViewController.m
//  RedditTop50
//
//  Created by Carlos Peralta on 16/11/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import "ViewController.h"
#import "DAO.h"
#import "Article.h"
#import "TableViewCell.h"
#import "WebVC.h"

@interface ViewController ()<ArticlesArriveProtocol, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityI;
@property (nonatomic, strong) NSArray *arrArticles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Reddit Top 50";
    
    [self.activityI startAnimating];
    
    _arrArticles = [[NSArray alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.hidden = true;
    
    DAO *dao = [[DAO alloc] init];
    dao.daoDelegate = self;
    [dao getTop50];
    
}

- (void)articlesArrive:(NSArray *)articles{
    _arrArticles = articles;
    NSLog(@"articlesArrive arts: %@",_arrArticles);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.activityI stopAnimating];
        self.tableView.hidden = false;
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrArticles count];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell * cell = (UITableViewCell*)sender;
        NSIndexPath *indexPathSelectedCell = [self.tableView indexPathForCell:cell];
        WebVC *webVC = (WebVC*)segue.destinationViewController;
        
        Article *art = (Article*)[_arrArticles objectAtIndex:indexPathSelectedCell.row];
        webVC.urlImage = art.fullSizeImageURL;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    Article *art = (Article*)[_arrArticles objectAtIndex:indexPath.row];
    
    TableViewCell *cell = nil;
    
    if (art.haveThumbnail) {
        cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ArticleCell" forIndexPath:indexPath];
    }else{
        cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ArticleCellNOImage" forIndexPath:indexPath];
    }
 
    cell.title.text = art.title;
    cell.author.text = [NSString stringWithFormat:@"by %@", art.author];
    cell.hours.text = art.entryDateFormatedXAgoStyle;
    cell.comments.text = [NSString stringWithFormat:@"%@ comments", art.numbersOfComments];
    cell.thumbImageIM.hidden = true;
    
    if (art.haveThumbnail) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
        NSIndexPath *indexBeforeBackground = indexPath;
        dispatch_async(queue, ^{
            NSURL *url = [NSURL URLWithString:art.thumbnailURL];
            UIImage *img = [UIImage imageWithCIImage:[CIImage imageWithContentsOfURL:url]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if ([tableView cellForRowAtIndexPath:indexBeforeBackground]) {
                    cell.thumbImageIM.image = img;
                    cell.thumbImageIM.hidden = false;
                }
            });
        });
    }
  
    
    return cell;
}



@end