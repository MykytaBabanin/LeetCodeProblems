//
//  ViewController.swift
//  ArrayQuestions
//
//  Created by Никита Бабанин on 03/10/2023.
//

import UIKit

//Two Sum -> https://leetcode.com/problems/two-sum/description/
//Best Time to Buy and Sell Stock -> https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
//Contains Duplicate -> https://leetcode.com/problems/contains-duplicate/description/
//Product of Array Except Self -> https://leetcode.com/problems/product-of-array-except-self/description/
//Maximum Subarray -> https://leetcode.com/problems/maximum-subarray/
//Maximum Product Subarray -> https://leetcode.com/problems/maximum-product-subarray/
//Find Minimum in Rotated Sorted Array -> https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/
//Search in Rotated Sorted Array -> https://leetcode.com/problems/search-in-rotated-sorted-array/
//3 Sum -> https://leetcode.com/problems/3sum/description/
//Container With Most Water ->

class ArrayProblems: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(maxProfit([7, 1, 5, 3, 6, 4]))
    }
    
    //https://leetcode.com/problems/two-sum/description/
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<nums.count {
            if let idx = nums.firstIndex(of: target - nums[i]), i != idx {
                return [idx, i]
            }
        }
        return []
    }
    
    //https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
    
    func maxProfit(_ prices: [Int]) -> Int {
        var minPrice = prices[0]
        var maxPrice = 0
        
        for i in 0..<prices.count {
            if prices[i] < minPrice {
                minPrice = prices[i]
            }
            
            maxPrice = max(maxPrice, prices[i] - minPrice)
        }
        
        return maxPrice
    }
    
    //https://leetcode.com/problems/contains-duplicate/description/
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var duplicateArray: [Int] = []
        
        for i in 0..<nums.count {
            if duplicateArray.contains(nums[i]) {
                return true
            } else {
                duplicateArray.append(nums[i])
            }
        }
        return false
    }
    
    //https://leetcode.com/problems/product-of-array-except-self/description/
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var answer = Array(repeating: 0, count: nums.count)
        var right = Array(repeating: 0, count: nums.count)
        var left = Array(repeating: 0, count: nums.count)
        
        // left
        left[0] = 1
        for i in 1..<nums.count {
            left[i] = left[i - 1] * nums[i - 1]
        }
        
        // right
        right[nums.count - 1] = 1
        for i in (0..<nums.count - 1).reversed() {
            right[i] = right[i + 1] * nums[i + 1]
        }
        
        // left * right
        for i in 0..<nums.count {
            answer[i] = left[i] * right[i]
        }
        return answer
    }
    
    
    //https://leetcode.com/problems/maximum-subarray/
    
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 1 else { return nums[0] }
        var maxSum = nums[0]
        var currentSum = nums[0]
        
        for i in 1..<nums.count {
            currentSum = max(nums[i], currentSum + nums[i])
            maxSum = max(maxSum, currentSum)
        }
        return maxSum
    }
    
    //https://leetcode.com/problems/maximum-product-subarray/
    
    func maxProduct(_ nums: [Int]) -> Int {
        var maxPrice = nums[0]
        var minPrice = nums[0]
        var maxProduct = nums[0]
        
        for i in 1..<nums.count {
            if nums[i] < 0 {
                swap(&maxPrice, &minPrice)
            }
            
            maxPrice = max(nums[i], maxPrice * nums[i])
            minPrice = min(nums[i], minPrice * nums[i])
            
            maxProduct = max(maxProduct, maxPrice)
        }
        
        return maxProduct
    }
    
    //https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/
    
    func findMin(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        
        while (left < right) {
            let mid = (left + right) / 2
            
            if nums[right] < nums[mid] {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return nums[left]
    }
    
    //https://leetcode.com/problems/search-in-rotated-sorted-array/
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 1 else { return -1 }
        var start = 0
        var end = nums.count - 1
        
        while start < end {
            let mid = (start + end) / 2
            
            if nums[mid] > target {
                start += 1
            } else if nums[mid] < target {
                end -= 1
            } else if nums[mid] == target {
                return mid
            }
        }
        return -1
    }
    
    
    //https://leetcode.com/problems/3sum/description/
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var reversed = nums.sorted()
        var threesomeArray: [[Int]] = [[]]
        
        for (index, value) in reversed.enumerated() {
            var left = index + 1
            var right = reversed.count - 1
            while left < right {
                var threesome = value + reversed[left] + reversed[right]
                if threesome == 0 {
                    threesomeArray.append([value, reversed[left], reversed[right]])
                    left += 1
                } else if threesome > 0 {
                    right -= 1
                } else if threesome < 0 {
                    left += 1
                }
            }
        }
        let distinct = threesomeArray.filter { !$0.isEmpty }
        let resulted = Array(Set(distinct))
        return resulted
    }
}

