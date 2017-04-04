#' Get the game status (number of fingers alive)
#'
#' @param game An \code{alicetwist} game object
#' @return A matrix representing the current state
#' of the game (number of fingers still alive) with
#' the players on the rows and the hands on the columns
#' @examples
#' game <- new_game()
#' game
#' game_status(game)
#' @export
game_status <- function(game) {
  stopifnot(inherits(game, "alicetwist"))
  game[["status"]]
}

#' Set the game status
#'
#' @param game An \code{alicetwist} game object
#' @param player The player whose hands are to
#' be modified
#' @param value A vector containing the new
#' number of fingers to assign to each hand
#' @export
#' @keywords internal
`game_status<-` <- function(game, player, value) {
  stopifnot(inherits(game, "alicetwist"))
  if (player > game[["players"]])
    stop("`player` must be at least equal to the number of players in the game",
         .call = FALSE)
  game[["status"]][player, ] <- value
  game
}

#' Get the number of players
#'
#' @param game An \code{alicetwist} game object
#' @export
#' @keywords internal
game_players <- function(game) {
  stopifnot(inherits(game, "alicetwist"))
  game[["players"]]
}

#' Get the number of hands
#'
#' @param game An \code{alicetwist} game object
#' @export
#' @keywords internal
game_hands <- function(game) {
  stopifnot(inherits(game, "alicetwist"))
  game[["hands"]]
}

#' Get the number of fingers
#'
#' @param game An \code{alicetwist} game object
#' @export
#' @keywords internal
game_fingers <- function(game) {
  stopifnot(inherits(game, "alicetwist"))
  game[["fingers"]]
}

#' Is the game allowing the split move?
#'
#' Split move allows players who have zero
#' fingers left in one hand to move fingers
#' from other hands.
#'
#' @param game An \code{alicetwist} game object
#' @export
#' @keywords internal
game_split <- function(game) {
  stopifnot(inherits(game, "alicetwist"))
  game[["split"]]
}
