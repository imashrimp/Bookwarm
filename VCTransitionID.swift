//
//  VCTransitionID.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/02.
//

import Foundation

/// 이 열거형은 화면전환 방법에 따른 화면 해제(?)방법을 정하기 위한 식별자
/*가령, present로 전환시 pagesheet, fullscreen에 따라 이전 화면으로 되돌아가는 방법이 다른 경우를 대비함.
 열거형으로 하니까 코드를 봤을 때 더 직관적임.*/
enum TransitionID {
    case present
    case push
}
