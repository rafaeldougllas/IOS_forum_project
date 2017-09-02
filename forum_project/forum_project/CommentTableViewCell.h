//
//  CommentTableViewCell.h
//  forum_project
//
//  Created by Rafael Douglas on 28/08/17.
//  Copyright © 2017 com.rafael.douglas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
