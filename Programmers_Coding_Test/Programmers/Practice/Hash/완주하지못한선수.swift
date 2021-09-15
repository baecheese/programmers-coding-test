//
//  완주하지못한선수.swift
//  Programmers
//
//  Created by 배지영 on 2021/08/06.
//

import Foundation
/*
 https://programmers.co.kr/learn/courses/30/lessons/42576
 
 문제 설명
 수많은 마라톤 선수들이 마라톤에 참여하였습니다. 단 한 명의 선수를 제외하고는 모든 선수가 마라톤을 완주하였습니다.

 마라톤에 참여한 선수들의 이름이 담긴 배열 participant와 완주한 선수들의 이름이 담긴 배열 completion이 주어질 때, 완주하지 못한 선수의 이름을 return 하도록 solution 함수를 작성해주세요.

 제한사항
 마라톤 경기에 참여한 선수의 수는 1명 이상 100,000명 이하입니다.
 completion의 길이는 participant의 길이보다 1 작습니다.
 참가자의 이름은 1개 이상 20개 이하의 알파벳 소문자로 이루어져 있습니다.
 참가자 중에는 동명이인이 있을 수 있습니다.
 입출력 예
 participant    completion    return
 ["leo", "kiki", "eden"]    ["eden", "kiki"]    "leo"
 ["marina", "josipa", "nikola", "vinko", "filipa"]    ["josipa", "filipa", "marina", "nikola"]    "vinko"
 ["mislav", "stanko", "mislav", "ana"]    ["stanko", "ana", "mislav"]    "mislav"
 입출력 예 설명
 예제 #1
 "leo"는 참여자 명단에는 있지만, 완주자 명단에는 없기 때문에 완주하지 못했습니다.

 예제 #2
 "vinko"는 참여자 명단에는 있지만, 완주자 명단에는 없기 때문에 완주하지 못했습니다.

 예제 #3
 "mislav"는 참여자 명단에는 두 명이 있지만, 완주자 명단에는 한 명밖에 없기 때문에 한명은 완주하지 못했습니다.
 */

func non_finishPlayer(participant: [String], completion: [String]) -> String {
    var participantList: [String: Int] = [:]
    for player in participant {
        let sameName = participantList[player] ?? 0
        participantList[player] = (sameName + 1)
    }
    for player in completion {
        guard let _ = participantList[player] else { continue }
        participantList[player]! -= 1
    }
    return participantList.filter({ 1 == $1 }).first?.key ?? "" 
}


/* >> Java version
 
 class Solution {
     public String solution(String[] participant, String[] completion) {
         if (1 == participant.length) {
             return participant[0];
         }
         int[] checkParticipant = new int[participant.length];
         for (int participantIndex = 0; participantIndex < checkParticipant.length; participantIndex++) {
             for (int completionIndex = 0; completionIndex < completion.length; completionIndex++) {
                 String currentCompletion = completion[completionIndex];
                 String currentParticipant = participant[participantIndex];
                 int hasCache = checkParticipant[participantIndex];
                 if ((currentCompletion.equals(currentParticipant)) && (0 == hasCache)) {
                     checkParticipant[participantIndex] = 1;
                     break;
                 }
             }
         }
         for (int index = 0; index < checkParticipant.length; index++) {
             if (0 == checkParticipant[index]) {
                 return participant[index];
             }
         }
         return participant[0];
     }
 }
 
 */
