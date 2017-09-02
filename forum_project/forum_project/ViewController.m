//
//  ViewController.m
//  forum_project
//
//  Created by Rafael Douglas on 27/08/17.
//  Copyright © 2017 com.rafael.douglas. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager
                                              manager];
    
    //crystian@roadmaps.com.br
    //12345678
    
    [SVProgressHUD show];
    
    [manager POST: @"https://teste-aula-ios.herokuapp.com/users/sign_in.json"
       parameters:@{ @"user" : @{ @"email": self.user_field.text,
                                  @"password": self.password_field.text} }
          success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull
                    responseObject) {
              NSLog(@"Login success");
              
              [SVProgressHUD dismiss];
              
              UINavigationController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationViewController"];
              
              
              [self presentViewController:viewController animated:YES completion:nil];
              
          } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError *
                      _Nonnull error) {
              [SVProgressHUD dismiss];
              NSLog(@"Login failure");
              
              //Create a alert to show failed message
              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Falha no login" message:@"Email ou senha inválido(s)!" preferredStyle: UIAlertControllerStyleAlert];
              
              UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok"  style:UIAlertActionStyleDefault
                                                               handler:nil];
              
              [alertController addAction:okButton];
            
              [self presentViewController:alertController animated:YES completion:nil];
              
          }];
}
@end
