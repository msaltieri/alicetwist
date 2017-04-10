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
  )
)
