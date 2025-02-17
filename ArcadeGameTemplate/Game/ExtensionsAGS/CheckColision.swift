
//  CheckColision.swift
//  ArcadeGameTemplate
//
//  Created by Vitor Kalil on 14/12/23.
//
import SpriteKit
import SwiftUI
import UIKit

extension ArcadeGameScene {
    func checkColision(){
        var hitEnemies:[SKSpriteNode] = []

        enumerateChildNodes(withName:"soul"){node,_  in
            let enemy = node as! SKSpriteNode
            if CGRectIntersectsRect(CGRect(origin: enemy.frame.origin, size: CGSize(width: 60, height: 30)),self.skeleton.frame){
                hitEnemies.append(enemy)
            }
        }
        for enemy in hitEnemies{
            let deadAnimationR:SKAction
            var texturesDead:[SKTexture] = []
            for i in 0...4 {
                texturesDead.append(SKTexture(imageNamed:"soul_disappear_anim_f\(i)_L"))
            }
            deadAnimationR = SKAction.animate(with: texturesDead, timePerFrame: 0.1)

            if skeleton.action(forKey: "attackAnimation") == nil {
                if skeleton.action(forKey:"walkingAnimationR") != nil{
                    let attackAnimation:SKAction
                    var textures:[SKTexture] = []
                    for i in 0...9 {
                        textures.append(SKTexture(imageNamed:"reaper_attack_anim_f\(i)_R"))
                    }
                    attackAnimation = SKAction.animate(with: textures, timePerFrame: 0.05,resize: true, restore: true)
                    skeleton.run(attackAnimation,withKey: "attackAnimation")
                    ArcadeGameLogic.shared.increasePlayerHealth()
                }
                else if skeleton.action(forKey:"walkingAnimationL") != nil{
                    let attackAnimation:SKAction
                    var textures:[SKTexture] = []
                    for i in 0...9 {
                        textures.append(SKTexture(imageNamed:"reaper_attack_anim_f\(i)_L"))
                    }
                    attackAnimation = SKAction.animate(with: textures, timePerFrame: 0.05,resize:true, restore: true)
                    skeleton.run(attackAnimation,withKey: "attackAnimation")
                    ArcadeGameLogic.shared.increasePlayerHealth()


                }
            }
            enemy.removeAllActions()
            enemy.run(deadAnimationR) {
                enemy.removeFromParent()
                ArcadeGameLogic.shared.currentScore += 1
            }
            
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            

        }
    }
}
