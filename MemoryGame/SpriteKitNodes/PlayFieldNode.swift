//
//  PlayFieldNode.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/12/19.
//

import SpriteKit

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
        let waitAction = SKAction.wait(forDuration: 1.0)

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

    func layout() {
        guard let gameSize = self.gameSize else {
            return
        }
        self.layout(cards: self.cards, gameSize: gameSize)
    }

    func layout(cards: [CardNode], gameSize: GameSize) {

        guard let scene = self.scene else {
            return
        }

        let maxPlayFieldSize = PlayFieldNode.maxPlayFieldSize(fromSreenSize: scene.size)

        self.size = maxPlayFieldSize
        let maxCardSize = GameCard.backTexture().size()

        let cardSize = PlayFieldNode.suggestedCardSize(fromPlayFieldSize: self.size, andGameSize: gameSize)

        for (index, card) in cards.enumerated() {
            let cardIndex = gameSize.cardIndexPath(forArrayIndex: index)

            card.size = cardSize
            card.position = CGPoint(x: cardSize.width * (CGFloat(cardIndex.section) * (1 + PlayFieldNode.spacingRatio) + 0.5) - 0.5 * maxPlayFieldSize.width,
                                    y: cardSize.height * (CGFloat(cardIndex.row) * (1 + PlayFieldNode.spacingRatio) + 0.5) - 0.5 * maxPlayFieldSize.height)
        }
    }

    // computes the playfield size from margins
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
}
