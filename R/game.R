#' Initialize a new Alice Twist game
#'
#' Create an Alice Twist game that can
#' be played by two users or against
#' the CPU.
#'
#' @param players The number of players.
#' \code{players} at the moment can be
#' between 2 and 4 even if some methods
#' are built for two players only.
#' @param hands The number of hands for
#' each player. Since this implementation
#' come from the original kids game, the
#' buckets that each player has are call
#' hands. \code{hands} must be integer
#' but at the moment its number has no
#' limit.
#' @param fingers The number of fingers
#' for each hand. Also in this case the
#' name of the variable is derived from
#' the kids game but in this general form
#' the number of \code{fingers} could be
#' different from 5, provided that it
#' must be integer.
#' @param split If \code{TRUE}, then
#' every time a split is possibile during
#' the game it is performed. If \code{FALSE}
#' the split is never performed.
#' @return A \code{alicetwist} game object.
#' @examples
#' new_game()
#' @export
new_game <- function(players = 2,
                     hands = 2,
                     fingers = 5,
                     split = TRUE) {

  # Make sure the number of players is integer
  if (players %% 1 != 0)
    stop("number of `players` must be integer",
         .call = FALSE)

  # There must be at least 2 players
  if (players < 2)
    stop("number of `players` must be at least 2",
         call. = FALSE)

  # Make sure the number of hands is integer
  if (hands %% 1 != 0)
    stop("number of `hands` must be integer",
         .call = FALSE)

  # There must be at least 2 hands
  if (hands < 2)
    stop("number of `hands` must be at least 2",
         call. = FALSE)

  # Make sure the number of fingers is integer
  if (fingers %% 1 != 0)
    stop("number of `fingers` must be integer",
         .call = FALSE)

  # There must be at least 3 fingers
  if (fingers < 3)
    stop("number of `fingers` must be at least 3",
         call. = FALSE)

  # Generate the initial status
  game <- list(
    status = matrix(data = 1,
                    nrow = players,
                    ncol = hands),
    players = players,
    hands = hands,
    fingers = fingers,
    split = split
  )

  structure(game, class = 'alicetwist')

}

#' Print an alicetwist game
#' @export
#' @keywords internal
print.alicetwist <- function(x, ...) {
  cat("Alice Twist: ",
      game_players(x), " players, ",
      game_hands(x), " hands and ",
      game_fingers(x), " fingers",
      "\n", sep = "")
  cat("Game mode:",
      ifelse(game_split(x), "split allowed", "no split"),
      "\n\n\t")
  board <- game_status(x)
  row.names(board) <- paste("Player", 1:game_players(x))
  utils::write.table(x = board,
                     col.names = FALSE,
                     sep = "\t",
                     eol = "\n\n\t")
}
