source("global.R")

fluidPage(
  title = "Alice Twist / Michele Stefano Altieri",
  shinyjs::useShinyjs(),

  # Page header
  tags$head(
    # Style
    tags$link(href = "style.css", rel = "stylesheet")
  ),

  # Header
  div(id = "header",
      div(id = "title",
          "Alice Twist"
          ),
      div(id = "subtitle",
          "Created by",
          tags$a(href = "mailto:michelestefano.altieri@gmail.com?Subject=Alice%20Twist",
                 target = "_top",
                 "Michele Stefano Altieri"),
          HTML("&bull;"),
          "Package available",
          tags$a(href = "https://github.com/msaltieri/alicetwist",
                 "on GitHub")
          )
  ),

  # App Body
  fluidRow(
    column(4, wellPanel(
      id = "leftPanel",
      selectInput("finger",
                  "Saturation level",
                  3:7,
                  5),
      selectInput("split",
                  "Is split allowed?",
                  c("Yes" = TRUE,
                    "No" = FALSE)),
      actionButton("newgame",
                   "New Game",
                   class = "btn-lg"),
      hr(),
      p("Alice Twist is an interactive game in which each player",
        "has two or more baskets of balls. The goal of the game",
        "is to get your opponent without balls hitting his baskets",
        "with one of its own baskets. When your opponent's basket",
        "gets hit, the number of balls becomes equal to the sum of",
        "those already present and those contained in the basket",
        "with which you hit. When you reach the", em("saturation level"),
        "of the basket, the basket is empty and no longer have",
        "balls available. If the", em("split"), "is allowed, empty",
        "baskets are filled automatically by the balls in other baskets.")
    )),
    column(8,
           hidden(div(id = "congrats",
                      "Good job, you won!")),
           uiOutput("game")
    )
  )
)
