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

@interface ViewController ()<ArticlesArriveProtocol, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *arrArticles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrArticles = [[NSArray alloc] init];
    self.tableView.dataSource = self;
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ArticleCell" forIndexPath:indexPath];
    
    Article *art = (Article*)[_arrArticles objectAtIndex:indexPath.row];
    cell.title.text = art.title;
    cell.author.text = [NSString stringWithFormat:@"by %@", art.author];
    cell.hours.text = art.entryDateFormatedXAgoStyle;
    cell.comments.text = [NSString stringWithFormat:@"%@ comments", art.numbersOfComments];
    
    return cell;
}


@end