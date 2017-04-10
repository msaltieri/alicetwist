source("global.R")

# library(alicetwist)

server <- function(input, output, session) {

  # Variables definition
  values <- reactiveValues(
    players = NULL,
    hands = NULL,
    fingers = NULL,
    split = NULL,
    game = NULL,
    active = NULL
  )

  # New game button is clicked
  observeEvent(input$newgame, ignoreNULL = FALSE, {
    values$players <- 2 # at the moment only 2 players are allowed
    values$hands <- 2 # at the moment only 2 hands are allowed
    values$fingers <- as.numeric(input$finger)
    values$split <- input$split
    values$game <- new_game(fingers = values$fingers,
                            split = values$split)
    values$active <- TRUE
  })

  # Game representation
  output$game <- renderUI({
    values$game

    isolate({
      div(
        id = "game-inner",
        class = ifelse(values$active, "active", "inactive"),
        div(id = "game-shield"),

        tagList(
          div(class = "player",
              lapply(seq(values$hands), function(hand) {
                player <- 2
                value <- game_status(values$game)[player, hand]
                visClass <- ifelse(value == 0, "empty", "active")
                id <- sprintf("player%s-hand%s",
                              player,
                              hand)
                actionLink(
                  id,
                  value,
                  class = paste("opponent-hand", visClass),
                  `player` = player,
                  `hand` = hand
                )
              })
          ),
          div()
        )
      )
    })
  })
}
