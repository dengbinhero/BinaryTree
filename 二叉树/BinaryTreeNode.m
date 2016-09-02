//
//  BinaryTreeNode.m
//  二叉树
//
//  Created by Dengshengbin_breadtrip on 16/8/7.
//  Copyright © 2016年 面包旅行. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

/*
 * 创建二叉树排序树节点
 * 左节点值全部小于根节点，右节点值全部大于根节点
 * @return 二叉树根节点
 */
+ (BinaryTreeNode *)creatTreeWithValues:(NSArray *)values {
    BinaryTreeNode *root = nil;
    for (NSInteger i = 0; i < values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [BinaryTreeNode addTreeNode:root value:value];
    }
    return root;
}

/*
 * 向二叉排序树添加一个节点
 * treeNode 根节点
 * value 值
 * @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node: %@", @(value));
    } else if (value <= treeNode.value) {
        NSLog(@"to left");
        //值小于根节点
        treeNode.leftNode = [BinaryTreeNode addTreeNode:treeNode.leftNode value:value];
    } else {
        NSLog(@"to right");
        //值大于根节点
        treeNode.rightNode = [BinaryTreeNode addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

/*
 *  二叉树中某个位置的节点（按层次遍历）
 * index 按层次遍历的位置
 * rootNode 根节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode {
    if (index == 0 && rootNode == nil) {
        return nil;
    }
    
    NSMutableArray *queueArray = [@[] mutableCopy]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        BinaryTreeNode *node = queueArray.firstObject;
        if (index == 0) {
            return node;
        }
        
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，返照队列先进先出的原则
        index--; //节点移除，index减少
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压力右节点
        }
    }
    return nil;
}

/*
 * 先序遍历
 * 先访问根，再遍历左子树，再遍历右子树，典型的递归思想
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        if (handler) {
            handler(rootNode);
        }
        [BinaryTreeNode preOrderTraverseTree:rootNode.leftNode handler:handler];
        [BinaryTreeNode preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/*
 * 中序遍历
 * 先遍历左子树，再访问根，再遍历右子树
 */
+ (void)inOrderTreverseTree:(BinaryTreeNode *)rootNode handle:(void (^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [BinaryTreeNode inOrderTreverseTree:rootNode.leftNode handle:handler];
        if (handler) {
            handler(rootNode);
        }
        [BinaryTreeNode inOrderTreverseTree:rootNode.rightNode handle:handler];
    }
}

/*
 * 后序遍历
 * 先遍历左子树，再遍历右子树，在访问根
 */
+ (void)postOrderTreverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        
        [BinaryTreeNode postOrderTreverseTree:rootNode.leftNode handler:handler];
        [BinaryTreeNode postOrderTreverseTree:rootNode.rightNode handler:handler];
        if (handler) {
            handler(rootNode);
        }
    }
}

/*
 * 层次遍历
 * 从上到下，从左到右，先遍历完一层再遍历下一层，又叫广度优先遍历
 */
+ (void)levelTraverTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        NSMutableArray *queueArray = [@[] mutableCopy];
        [queueArray addObject:rootNode];
        
        while (queueArray.count > 0) {
            BinaryTreeNode *node  = queueArray.firstObject;
            if (handler) {
                handler(node);
            }
            [queueArray removeObjectAtIndex:0];
            if (node.leftNode) {
                [queueArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queueArray addObject:node.rightNode];
            }
        }
    }
}

/**
 *  二叉树的深度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    //左子树深度
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    //右子树深度
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    
    return MAX(leftDepth, rightDepth) + 1;
}

/*
 * 翻转二叉树
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    
    if (!rootNode) {
        return nil;
    }
    
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    
    return rootNode;
}

/*
 * 二树叉的宽度
 * 各层节点数的最大值
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)treeNode {
    
    if (!treeNode) {
        return 0;
    }
    
    NSInteger maxWidth = 1; //最大宽度
    NSInteger curWidth = 0; //当前最大宽度
    NSMutableArray *treeArray = [@[] mutableCopy];
    [treeArray addObject:treeNode];
    while (treeArray.count > 0) {
        curWidth = treeArray.count;
        //依次弹出当前层的节点
        for (NSInteger i = 0; i < curWidth; i++) {
            BinaryTreeNode *tree = treeArray.firstObject;
            [treeArray removeObjectAtIndex:0];
            if (tree.leftNode) {
                [treeArray addObject:tree.leftNode];
            }
            if (tree.rightNode) {
                [treeArray addObject:tree.rightNode];
            }
        }
        maxWidth = MAX(maxWidth, treeArray.count);
    }
    
    return maxWidth;
}

@end
