//
//  위장.swift
//  Programmers
//
//  Created by 배지영 on 2021/08/12.
//

import Foundation

/*
 문제 설명
 스파이들은 매일 다른 옷을 조합하여 입어 자신을 위장합니다.

 예를 들어 스파이가 가진 옷이 아래와 같고 오늘 스파이가 동그란 안경, 긴 코트, 파란색 티셔츠를 입었다면 다음날은 청바지를 추가로 입거나 동그란 안경 대신 검정 선글라스를 착용하거나 해야 합니다.

 종류    이름
 얼굴    동그란 안경, 검정 선글라스
 상의    파란색 티셔츠
 하의    청바지
 겉옷    긴 코트
 스파이가 가진 의상들이 담긴 2차원 배열 clothes가 주어질 때 서로 다른 옷의 조합의 수를 return 하도록 solution 함수를 작성해주세요.

 제한사항
 clothes의 각 행은 [의상의 이름, 의상의 종류]로 이루어져 있습니다.
 스파이가 가진 의상의 수는 1개 이상 30개 이하입니다.
 같은 이름을 가진 의상은 존재하지 않습니다.
 clothes의 모든 원소는 문자열로 이루어져 있습니다.
 모든 문자열의 길이는 1 이상 20 이하인 자연수이고 알파벳 소문자 또는 '_' 로만 이루어져 있습니다.
 스파이는 하루에 최소 한 개의 의상은 입습니다.
 입출력 예
 clothes    return
 [["yellowhat", "headgear"], ["bluesunglasses", "eyewear"], ["green_turban", "headgear"]]    5
 [["crowmask", "face"], ["bluesunglasses", "face"], ["smoky_makeup", "face"]]    3
 입출력 예 설명
 예제 #1
 headgear에 해당하는 의상이 yellow_hat, green_turban이고 eyewear에 해당하는 의상이 blue_sunglasses이므로 아래와 같이 5개의 조합이 가능합니다.

 1. yellow_hat
 2. blue_sunglasses
 3. green_turban
 4. yellow_hat + blue_sunglasses
 5. green_turban + blue_sunglasses
 예제 #2
 face에 해당하는 의상이 crow_mask, blue_sunglasses, smoky_makeup이므로 아래와 같이 3개의 조합이 가능합니다.

 1. crow_mask
 2. blue_sunglasses
 3. smoky_makeup
 */

func camouflage(_ clothes:[[String]]) -> Int {
    let room = DressRoom(clothes)
    return room.allPattern().count
}

class Clothes: Equatable {
    
    let name: String
    let kind: String
    
    init(value: [String]) {
        self.name = value[0]
        self.kind = value[1]
    }
    
    func canWear(with other: Clothes) -> Bool {
        return kind != other.kind
    }
    
    static func == (lhs: Clothes, rhs: Clothes) -> Bool {
        return lhs.kind == rhs.kind && lhs.name == rhs.name
    }
    
}

class DressRoom {
    
    let clothes: [Clothes]
    
    // key: 의상의 종류
    var folder: [String: [Clothes]] {
        var temp: [String: [Clothes]] = [:]
        clothes.forEach {
            if nil == temp[$0.kind] {
                temp[$0.kind] = [$0]
            } else {
                temp[$0.kind]?.append($0)
            }
        }
        return temp
    }
    
    init(_ dataSource:[[String]]) {
        clothes = dataSource.map { Clothes(value: $0) }
    }
    
    func allPattern() -> [[Clothes]] {
        var result: [[Clothes]] = []
        for count in 1...clothes.count {
            mix(spare: clothes, total: count).forEach {
                result.append($0)
            }
        }
        return result
    }
    
    private func mix(spare: [Clothes], total: Int) -> [[Clothes]] {
        guard 0 < total else {
            return []
        }
        guard 1 < total else {
            return spare.map { [$0] }
        }
        var result: [[Clothes]] = []
        for index in 0...spare.count-1 {
            let contain = spare[index]
            let nextIndex: Int = index == spare.count - 1 ? (spare.count - 1) : (index + 1)
            // 다음 배열부터의 남은 옷
            let nextSpare: [Clothes] = Array(spare[nextIndex..<spare.count])
            for current in mix(spare: nextSpare, total: total-1) {
                let filtered = current
                    .filter({
                        $0.kind != contain.kind
                        && $0 != contain
                    })
                guard filtered.count == current.count else { continue }
                var v = current
                v.insert(spare[index], at: 0)
                result.append(v)
            }
        }
        return result
    }
    
}
