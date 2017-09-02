//
//  CommentsViewController.m
//  forum_project
//
//  Created by Rafael Douglas on 28/08/17.
//  Copyright © 2017 com.rafael.douglas. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentTableViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD.h>

@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Inicializa os parametros
    self.comments = [NSMutableArray arrayWithArray: @[]];
    self.page = 1;
    
    // Isso aqui diz pra o iOS não criar espaços em cima das scrollviews, por causa do navigation bar
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshData];
}

- (IBAction)refresh:(id)sender {
    [self refreshData];
}


- (void)refreshData {
    self.page = 1;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [SVProgressHUD show];
    [manager GET:@"https://teste-aula-ios.herokuapp.com/comments.json"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [SVProgressHUD dismiss];
             self.comments = [NSMutableArray arrayWithArray:responseObject];
             [self.tableview reloadData];
         }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD dismiss];
             NSLog(@"Error: %@", error);
         }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *comment = self.comments[indexPath.row];
    cell.userLabel.text = comment[@"user"];
    cell.commentLabel.text = comment[@"content"];
    cell.dateLabel.text = [comment[@"created_at"] substringToIndex:10];
    [cell.userImg setImageWithURL:[NSURL URLWithString:comment[@"image"]]
                     placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
    
    if (indexPath.row == [self.comments count] - 1) {
        // Última célula, tenta carregar mais
        [self loadNextPage];
    }
    
    return cell;
    
}

- (void) loadNextPage {
    if (self.page == -1)
        return;
    self.page += 1;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:@"https://teste-aula-ios.herokuapp.com/comments.json"
      parameters:@{@"page":@(self.page)}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject count] == 0) {
                 // This will stop pagination from happening
                 self.page = -1;
             } else {
                 [self.comments addObjectsFromArray:responseObject];
                 [self.tableview reloadData];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Update data source array here, something like [array removeObjectAtIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"DELETOU!!!!!");
    }
}

@end
