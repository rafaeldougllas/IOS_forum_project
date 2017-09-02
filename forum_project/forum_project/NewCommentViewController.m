//
//  NewCommentViewController.m
//  forum_project
//
//  Created by Rafael Douglas on 30/08/17.
//  Copyright © 2017 com.rafael.douglas. All rights reserved.
//

#import "NewCommentViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface NewCommentViewController ()

@end

@implementation NewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)attachCommentImage:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"AViso" message:@"Escolha" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction *galeryAction = [UIAlertAction actionWithTitle:@"Galeria" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker =  [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    [alert addAction:galeryAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    editedImage = (UIImage *) info[UIImagePickerControllerEditedImage];
    originalImage = (UIImage *) info[UIImagePickerControllerOriginalImage];
    
    if (editedImage) {
        imageToSave = editedImage;
    } else {
        imageToSave = originalImage;
    }
    
    // Save the new image (original or edited) to the Camera Roll
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    
    UIImage *image = imageToSave;
    self.imgAttached.image   = image;
    
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)sendMessage:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *parameters = @{
                                 @"comment[user]":self.userField.text,
                                 @"comment[content]":self.commentField.text
                                 };
    [SVProgressHUD show];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imgAttached.image, 0.7);
    
    [manager  POST:@"https://teste-aula-ios.herokuapp.com/comments.json"
        parameters:parameters
        constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //Quebra a imagem em partes
            [formData appendPartWithFileData: imageData name: @"comment[picture]" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
        }  success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
    
            NSLog(@"Error: %@", error);
            
            [self.navigationController popViewControllerAnimated:YES];
    
        }];

}



@end
