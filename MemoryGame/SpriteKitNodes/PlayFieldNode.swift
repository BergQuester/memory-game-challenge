//
//  PlayFieldNode.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/12/19.
//

import SpriteKit
import AVKit    // This may seem strage, but this contains an asepct fit method for CGRect

// TODO:
// * Figure out how big the cards should be (with a max size: 147x211)
//      * Probably use a % of height and width, take the smaller and keep ratio

class PlayFieldNode: SKSpriteNode {
    static let marginRatio: CGFloat = 0.1
    static let spacingRatio: CGFloat = 0.1

    var cards: [CardNode] = []
    var gameSize: GameSize?

    func addCard(_ card: CardNode) {
        self.addChild(card)
        self.cards.append(card)
    }
}

//MARK: - Card state
extension PlayFieldNode {
    func prepareResetActions(withGameState gameState: GameState) {

        // disable user interaction
        self.scene?.view?.isUserInteractionEnabled = false

        // delay the flips
        let duration = 1.0 + CardNode.flipAnimationDuration // This way the card flip animation
                                                            // doesn't count twoards our 1 second show time
        let waitAction = SKAction.wait(forDuration: duration)

        // Run action that performs the flips and re-enables user interaction
        let flipAction = SKAction.run { [weak self] in
            guard let strongSelf = self else {
                    return
            }

            strongSelf.resetUnmatchedCards(withGameState: gameState)
            strongSelf.scene?.view?.isUserInteractionEnabled = true
        }

        self.run(SKAction.sequence([waitAction, flipAction]))
    }

    func resetUnmatchedCards(withGameState gameState: GameState) {

        // Go through all of the card nodes and update them according to the model
        // In a more performance-intensive game we might optimize this
        // but in this game we're going to keep the logic simple
        self.cards.forEach { card in
            guard let cardModel = gameState.card(forIndexPath: card.cardIndex) else {
                return
            }

            card.update(withState: cardModel)
        }
    }
}


//MARK: - Card layout
extension PlayFieldNode {

    func layout(withSceneSize sceneSize: CGSize? = nil) {
        guard let gameSize = self.gameSize else {
            return
        }
        self.layout(cards: self.cards, gameSize: gameSize)
    }

    func layout(cards: [CardNode], gameSize: GameSize, withSceneSize sceneSize: CGSize? = nil) {

        let viewSize = sceneSize ?? self.scene?.size
        guard let sceneSize = viewSize else {
            return
        }

        // Compute the largest sizes we can use
        let maxPlayFieldSize = PlayFieldNode.maxPlayFieldSize(fromSreenSize: sceneSize)
        let maxCardSize = GameCard.backTexture().size()
        let suggestedCardSize = PlayFieldNode.suggestedCardSize(fromPlayFieldSize: maxPlayFieldSize, andGameSize: gameSize)

        // compute the final sizes
        let cardSize = AVMakeRect(aspectRatio: maxCardSize, insideRect: CGRect(origin: .zero, size: suggestedCardSize)).size
        self.size = PlayFieldNode.finalPlayfieldSize(withCardSize: cardSize, gameSize: gameSize)

        // layout cards
        for (index, card) in cards.enumerated() {
            let cardIndex = gameSize.cardIndexPath(forArrayIndex: index)

            card.size = cardSize
            card.position = CGPoint(x: cardSize.width * (CGFloat(cardIndex.section) * (1 + PlayFieldNode.spacingRatio) + 0.5) - 0.5 * self.size.width,
                                    y: cardSize.height * (CGFloat(cardIndex.row) * (1 + PlayFieldNode.spacingRatio) + 0.5) - 0.5 * self.size.height)
        }
    }

    // computes the max playfield size from margins
    private static func maxPlayFieldSize(fromSreenSize screenSize: CGSize) -> CGSize {
        return CGSize(width: screenSize.width - (screenSize.width * 2 * marginRatio),
                      height: screenSize.height - (screenSize.height * 2 * marginRatio))
    }

    private static func suggestedCardSize(fromPlayFieldSize fieldSize: CGSize, andGameSize gameSize: GameSize) -> CGSize {
        let cardWidth = self.suggestedCardDimension(fromPlayFieldDimension: fieldSize.width,
                                                     andCardCount: gameSize.numberOfColumns())

        let cardHeight = self.suggestedCardDimension(fromPlayFieldDimension: fieldSize.height,
                                                      andCardCount: gameSize.numberOfRows())

        let cardSize = CGSize(width: cardWidth, height: cardHeight)

        return cardSize
    }

    private static func suggestedCardDimension(fromPlayFieldDimension playFieldDimension: CGFloat, andCardCount numberOfCards: Int) -> CGFloat {
        // playFieldDimension = numberOfCards * cardDimension + (numberOfCards - 1) * cardDimension * spacingRatio
        // Solved for cardDimension on paper
        let numberOfCardsFloat = CGFloat(numberOfCards)
        let cardDimension = playFieldDimension / (numberOfCardsFloat + spacingRatio * numberOfCardsFloat - spacingRatio)
        return cardDimension
    }

    private static func finalPlayfieldSize(withCardSize cardSize: CGSize, gameSize: GameSize) -> CGSize {
        let numberOfColumns = CGFloat(gameSize.numberOfColumns())
        let numberOfRows = CGFloat(gameSize.numberOfRows())
        let size = CGSize(width: cardSize.width * (numberOfColumns + (numberOfColumns - 1) * spacingRatio),
                          height: cardSize.height * (numberOfRows + (numberOfRows - 1) * spacingRatio))

        return size
    }
}
