#' Play a single move in the game
#'
#' Pushing one hand of a player against the hand
#' of another player implies that the number of
#' fingers in the target hands becomes the sum
#' of the original fingers' number and the hitting
#' fingers' number, modulus the number of fingers
#' in the hands.
#'
#' @param game An \code{alicetwist} game object.
#' @param active_player The ID of the striker player.
#' @param active_hand The ID of the hand with which
#' the \code{active_player} hits the opponent's hand.
#' @param target_player The ID of the player who
#' undergoes the hit.
#' @param target_hand The ID of the hand which is
#' been hit.
#' @return A new \code{alicetwist} game object after
#' the given move is accomplished.
#' @seealso \code{\link[alicetwist]{new_game}}
#' @examples
#' # Create a basic game and then make a move
#'
#' game <- new_game()
#' game
#'
#' # Make a move
#' game_after_move <- play(game, 1, 1, 2, 1)
#' game_after_move
#'
#' # Make a move for both the players
#' game_after_move <- game %>% play(1, 1, 2, 1) %>% play(2, 1, 1, 1)
#' game_after_move
#' @export
play <- function(game,
                 active_player,
                 active_hand,
                 target_player,
                 target_hand) {
  stopifnot(inherits(game, "alicetwist"))

  # If only the active player is provided,
  # make a random move
  if (!is.null(active_player) && missing(active_hand) &&
      missing(target_player) && missing(target_hand)) {

    p1 <- active_player
    h1 <- sample(1:game_hands(game), 1)
    p2 <- sample(setdiff(1:game_players(game),
                         active_player), 1)
    h2 <- sample(1:game_hands(game), 1)

  } else {

    p1 <- active_player
    h1 <- active_hand
    p2 <- target_player
    h2 <- target_hand

  }

  # Make a move
  source_hands <- game_status(game)[p1, ]
  target_hands <- game_status(game)[p2, ]
  target_hands[h2] <- (target_hands[h2] + source_hands[h1]) %% game_fingers(game)
  game_status(game, p2) <- target_hands

  # Split rule
  if (game_split(game)) {
    hasZeroHand <- length(which(target_hands == 0)) > 0
    if (hasZeroHand) {
      isDivisible <- sum(target_hands) %% game_hands(game) == 0
      if (isDivisible) {
        target_hands <- sum(target_hands) / game_hands(game)
        game_status(game, p2) <- target_hands
      }
    }
  }

  # Check if game is ended
  if (sum(target_hands) == 0) {
    message("Player ", p1, " won!")
    invisible(game)
  } else {
    game
  }

}
