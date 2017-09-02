//
//  NewCommentViewController.h
//  forum_project
//
//  Created by Rafael Douglas on 30/08/17.
//  Copyright © 2017 com.rafael.douglas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCommentViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextView *commentField;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (strong, nonatomic) IBOutlet UIImageView *imgAttached;
@property (strong, nonatomic) UIImagePickerController *imagePicker;


@end
