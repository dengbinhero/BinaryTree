//
//  ViewController.m
//  二叉树
//
//  Created by Dengshengbin_breadtrip on 16/8/7.
//  Copyright © 2016年 面包旅行. All rights reserved.
//

#import "ViewController.h"
#import "BinaryTreeNode.h"

@interface ViewController ()

@property(nonatomic, strong) NSString *haha;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserver:self forKeyPath:@"haha" options:NSKeyValueObservingOptionNew context:nil];
    self.haha = @"xxx";
    _haha = @"hahhahah";
    
    NSArray *array = @[@1, @2, @10, @8, @3, @4, @5, @6, @7, @9];
    BinaryTreeNode *tree = [BinaryTreeNode creatTreeWithValues:array];
    NSLog(@"tree : %@", tree);
    
    BinaryTreeNode *indexNode = [BinaryTreeNode treeNodeAtIndex:5 inTree:tree];
    NSLog(@"indeNode : %ld", indexNode.value);
    
    NSMutableArray *preOrderArray = [@[] mutableCopy];
    [BinaryTreeNode preOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
        [preOrderArray addObject:@(treeNode.value)];
    }];
    NSLog(@"先序遍历的结果 : %@", preOrderArray);
    
    NSMutableArray *inOrderArray = [@[] mutableCopy];
    [BinaryTreeNode inOrderTreverseTree:tree handle:^(BinaryTreeNode *treeNode) {
       [inOrderArray addObject:@(treeNode.value)];
    }];
    NSLog(@"中序遍历的结果 : %@", inOrderArray);
    
    NSMutableArray *postOrderArray = [@[] mutableCopy];
    [BinaryTreeNode postOrderTreverseTree:tree handler:^(BinaryTreeNode *treeNode) {
        [postOrderArray addObject:@(treeNode.value)];
    }];
    NSLog(@"后序遍历的结果 : %@", postOrderArray);
    
    NSMutableArray *levelOrderArray = [@[] mutableCopy];
    [BinaryTreeNode levelTraverTree:tree handler:^(BinaryTreeNode *treeNode) {
        [levelOrderArray addObject:@(treeNode.value)];
    }];
    NSLog(@"层次遍历的结果 : %@", levelOrderArray);
    
    //二叉树的深度
    NSInteger depth = [BinaryTreeNode depthOfTree:tree];
    NSLog(@"depth : %ld", depth);
    
    //翻转二叉树
    BinaryTreeNode *invertTree = [BinaryTreeNode invertBinaryTree:tree];
    NSMutableArray *invertPreOrderArray = [@[] mutableCopy];
    [BinaryTreeNode preOrderTraverseTree:invertTree handler:^(BinaryTreeNode *treeNode) {
        [invertPreOrderArray addObject:@(treeNode.value)];
    }];
    NSLog(@"翻转后先序遍历的结果 : %@", invertPreOrderArray);
    
    NSInteger treeWidth = [BinaryTreeNode widthOfTree:tree];
    NSLog(@"宽度 : %ld", treeWidth);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"haha"]) {
        NSLog(@"haha 调用! : %@", change[@"new"]);
    }
}



@end
