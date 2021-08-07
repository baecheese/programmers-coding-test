//
//  주식가격.swift
//  Programmers
//
//  Created by 배지영 on 2021/08/06.
//

import Foundation
/*
 https://programmers.co.kr/learn/courses/30/lessons/42584
 
 문제 설명
 초 단위로 기록된 주식가격이 담긴 배열 prices가 매개변수로 주어질 때, 가격이 떨어지지 않은 기간은 몇 초인지를 return 하도록 solution 함수를 완성하세요.

 제한사항
 prices의 각 가격은 1 이상 10,000 이하인 자연수입니다.
 prices의 길이는 2 이상 100,000 이하입니다.
 입출력 예
 prices    return
 [1, 2, 3, 2, 3]    [4, 3, 1, 1, 0]
 입출력 예 설명
 1초 시점의 ₩1은 끝까지 가격이 떨어지지 않았습니다.
 2초 시점의 ₩2은 끝까지 가격이 떨어지지 않았습니다.
 3초 시점의 ₩3은 1초뒤에 가격이 떨어집니다. 따라서 1초간 가격이 떨어지지 않은 것으로 봅니다.
 4초 시점의 ₩2은 1초간 가격이 떨어지지 않았습니다.
 5초 시점의 ₩3은 0초간 가격이 떨어지지 않았습니다.
 ※ 공지 - 2019년 2월 28일 지문이 리뉴얼되었습니다.
 
 JAVA로 제출
 class Solution {
     public int[] solution(int[] prices) {
         if (prices.length <= 1) {
             int[] result = {0};
             return result;
         }
         int[] times = new int[prices.length];
         for (int index = 0; index < prices.length; index++) {
             int price = prices[index];
             if (index == (prices.length - 1)) {
                 times[index] = 0;
             } else {
                 for (int compareIndex = (index+1); compareIndex < prices.length; compareIndex++) {
                     int compare = prices[compareIndex];
                     times[index] += 1;
                     if (compare < price) {
                         break;
                     }
                     
                 }
             }
         }
         return times;
     }
 }
 
 
 */

func pricesStock(_ prices: [Int]) -> [Int] {
    guard 1 < prices.count else { return [0] }
    var result: [Int] = Array<Int>(repeating: 0, count: prices.count)
    for index in 0...(prices.count - 1) {
        let price = prices[index]
        if index == (prices.count - 1) {
            result[index] = 0
        } else {
            for compareIndex in ((index + 1)...prices.count - 1) {
                let comparePrice = prices[compareIndex]
                result[index] += 1
                if comparePrice < price { break }
            }
        }
    }
    return result
}
