//
//  CommentsViewController.h
//  forum_project
//
//  Created by Rafael Douglas on 28/08/17.
//  Copyright © 2017 com.rafael.douglas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong) NSMutableArray *comments;
@property (nonatomic) int page;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
