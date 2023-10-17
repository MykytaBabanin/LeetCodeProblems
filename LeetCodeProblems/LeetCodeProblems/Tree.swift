//
//  ViewController.swift
//  TreeLeetcodeQuestions
//
//  Created by Никита Бабанин on 11/10/2023.
//

import UIKit


class Node {
    var key: Int
    var value: Int
    
    var left: Node?
    var right: Node?
    
    init(key: Int, value: Int, left: Node? = nil, right: Node? = nil) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
    }
}

class Tree: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var root: Node? = Node(key: 10, value: 20)
        root = insert(node: root, key: 5, value: 15)
        root = insert(node: root, key: 15, value: 25)
        root = insert(node: root, key: 20, value: 1)
        
        printTree(root)
    }
    
    func insert(node: Node?, key: Int, value: Int) -> Node {
        guard let currentNode = node else {
            return Node(key: key, value: value)
        }
        
        if key < currentNode.key {
            currentNode.left = insert(node: currentNode.left, key: key, value: value)
        } else {
            currentNode.right = insert(node: currentNode.right, key: key, value: value)
        }
        
        return currentNode
    }
    
    func search(node: Node?, key: Int) -> Node? {
        guard let node = node else { return nil }
        if node.key == key {
            return node
        }
        
        return key < node.key ? search(node: node.left, key: key) : search(node: node.right, key: key)
    }
    
    func getMin(node: Node?) -> Node? {
        var current = node
        
        while current != nil {
            current = current?.left
        }
        
        return current
    }
    
    func getMax(node: Node?) -> Node? {
        var current = node
        
        while current != nil {
            current = current?.right
        }
        
        return current
    }
    
    
    func printTree(_ node: Node?, level: Int = 0, side: String? = nil) {
        guard let node = node else { return }
        
        var spacing = ""
        for _ in 0..<level {
            spacing += "  "
        }
        
        if let side = side {
            print("\(spacing)\(side): [\(node.key): \(node.value)]")
        } else {
            print("\(spacing)[\(node.key): \(node.value)]")
        }
        
        printTree(node.left, level: level + 1, side: "L")
        printTree(node.right, level: level + 1, side: "R")
    }

}

