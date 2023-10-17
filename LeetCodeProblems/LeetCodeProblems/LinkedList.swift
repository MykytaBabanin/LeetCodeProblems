//
//  ViewController.swift
//  LinkedListQuestions
//
//  Created by Никита Бабанин on 03/10/2023.
//

import UIKit

//Merge 2 sorted lists https://leetcode.com/problems/merge-two-sorted-lists/
//Reverse a Linked List https://leetcode.com/problems/reverse-linked-list/
//Detect Cycle in a Linked List https://leetcode.com/problems/linked-list-cycle/
//Merge Two Sorted Lists https://leetcode.com/problems/merge-two-sorted-lists/
//Merge K Sorted Lists https://leetcode.com/problems/merge-k-sorted-lists/
//Remove Nth Node From End Of List https://leetcode.com/problems/remove-nth-node-from-end-of-list/
//Reorder List https://leetcode.com/problems/reorder-list/

struct LinkedList<T> {
    var head: LinkedListNode<T>
    
    init(head: LinkedListNode<T>) {
        self.head = head
    }
}

indirect enum LinkedListNode<T> {
    case value(element: T, next: LinkedListNode<T>)
    case tail
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


class LinkedListProblems: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list1 = arrayToListNode([1, 4, 5])
        let list2 = arrayToListNode([1, 3, 4])
        let list3 = arrayToListNode([2, 6])
        let list4 = arrayToListNode([1,2,3,4,5])

        reorderList(list4)
        //printListNode(removeNthFromEnd(list4, 2))
    }
    
    //Merge 2 sorted lists https://leetcode.com/problems/merge-two-sorted-lists/
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var l1 = list1
        var l2 = list2
        
        let dummyHead = ListNode()
        var current = dummyHead
        
        while let node1 = l1, let node2 = l2 {
            if node1.val < node2.val {
                l1 = node1.next
                current.next = node1
            } else {
                l2 = node2.next
                current.next = node2
            }
            
            current = current.next!
        }
        
        if let remainingL1Value = l1 {
            current.next = remainingL1Value
        }
        
        if let remainingL2Value = l2 {
            current.next = remainingL2Value
        }
        
        return dummyHead.next
    }
    
    //Reverse a Linked List https://leetcode.com/problems/reverse-linked-list/
    func reverseList(_ head: ListNode?) -> ListNode? {
        // 1 -> 3 -> 5
        
        var current = head
        var prev: ListNode?
        var next: ListNode?
        
        while current != nil {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        
        return prev
    }
    
    //Merge K Sorted Lists https://leetcode.com/problems/merge-k-sorted-lists/
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var array: [[Int]] = [[]]
        
        for list in lists {
            array.append(listNodeToArray(list))
        }
        let resultedArray = array.flatMap { $0 }.sorted()
        let resultedList = arrayToListNode(resultedArray)
        
        return resultedList
    }
    
    //Remove Nth Node From End Of List https://leetcode.com/problems/remove-nth-node-from-end-of-list/
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var length = 0
        var current = head
        
        while current != nil {
            length += 1
            current = current?.next
        }
        
        let newHead = ListNode()
        var newCurrent = newHead
        current = head
        
        for _ in 0..<length {
            if length == n {
                current = current?.next
            } else {
                let newNode = ListNode(current!.val)
                newCurrent.next = newNode
                newCurrent = newCurrent.next!
                current = current?.next
            }
            
            length -= 1
        }
        
        return newHead.next
    }
    
    //Reorder List https://leetcode.com/problems/reorder-list/
    func reorderList(_ head: ListNode?) {
        var slow = head
        var fast = head
        
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        var first = head
        var second = reverseList(slow)
        
        while second != nil {
            let nextFirst = first?.next
            let nextSecond = second?.next
            
            first?.next = second
            second?.next = nextFirst
            
            first = nextFirst
            second = nextSecond
        }
        
        printListNode(head)
    }
}


private extension LinkedListProblems {
    func listNodeToArray(_ list: ListNode?) -> [Int] {
        var node = list
        var array: [Int] = []
        
        while node != nil {
            array.append(node?.val ?? 0)
            node = node?.next
        }
        
        return array
    }
    
    func arrayToListNode(_ array: [Int]) -> ListNode? {
        guard !array.isEmpty else {
            return nil
        }
        
        let head = ListNode(array[0])
        var current = head
        
        for i in 1..<array.count {
            current.next = ListNode(array[i])
            current = current.next!
        }
        
        return head
    }
    
    func printListNode(_ head: ListNode?) {
        var current = head
        
        while let node = current {
            print(node.val, terminator: " -> ")
            current = node.next
        }
        
        print("nil")
    }
}

