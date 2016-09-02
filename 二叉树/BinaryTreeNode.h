//
//  BinaryTreeNode.h
//  二叉树
//
//  Created by Dengshengbin_breadtrip on 16/8/7.
//  Copyright © 2016年 面包旅行. All rights reserved.
//

/*
 * 二叉树节点
 */

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

//值
@property(nonatomic, assign) NSInteger value;

//左节点
@property(nonatomic, strong) BinaryTreeNode *leftNode;

//右节点
@property(nonatomic, strong) BinaryTreeNode *rightNode;

/*
 * 创建二叉树排序树节点
 * 左节点值全部小于根节点，右节点值全部大于根节点
 * @return 二叉树根节点
 */
+ (BinaryTreeNode *)creatTreeWithValues:(NSArray *)values;

/*
 *  二叉树中某个位置的节点（按层次遍历）
 * index 按层次遍历的位置
 * rootNode 根节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode;

/*
 * 先序遍历
 * 先访问根，再遍历左子树，再遍历右子树，典型的递归思想
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;

/*
 * 中序遍历
 * 先遍历左子树，再访问根，再遍历右子树
 */
+ (void)inOrderTreverseTree:(BinaryTreeNode *)rootNode handle:(void (^)(BinaryTreeNode *treeNode))handler;

/*
 * 后序遍历
 * 先遍历左子树，再遍历右子树，在访问根
 */
+ (void)postOrderTreverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))handler;

/*
 * 层次遍历
 * 从上到下，从左到右，先遍历完一层再遍历下一层，又叫广度优先遍历
 */
+ (void)levelTraverTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))handler;

/**
 *  二叉树的深度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode;

/*
 * 翻转二叉树
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode;

/*
 * 二树叉的宽度
 * 各层节点数的最大值
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)treeNode;

@end
