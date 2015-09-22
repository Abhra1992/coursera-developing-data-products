library(shiny)
shinyUI(navbarPage("Finance Calculator",
  tabPanel("Basic Operations",
    tabsetPanel(type = "tabs",
      tabPanel("PV/FV Calculation",
        sidebarLayout(
          sidebarPanel(
            selectInput("basic.calc", label = "Calculate", choices = list("Present Value" = 0, "Future Value" = 1)),
            numericInput("basic.amount", label = "Amount", value = 100),
            sliderInput("basic.interest", label = "Interest Rate", min = 0, max = 20, step = 1, value = 5),
            sliderInput("basic.time", label = "Years", min = 0, max = 50, step = 1, value = 5),
            submitButton("Calculate"),
            h3("Answer"),
            textOutput("basic.value")
          ),
          mainPanel()
        )
      ),
      tabPanel("Number of Periods",
        sidebarLayout(
          sidebarPanel(
            numericInput("basic.p.present", label = "Present Value", value = 100),
            numericInput("basic.p.future", label = "Future Value", value = 100),
            sliderInput("basic.p.interest", label = "Interest Rate", min = 0, max = 20, step = 1, value = 5),
            submitButton("Calculate"),
            h3("Answer"),
            textOutput("basic.period")
          ),
          mainPanel()
        )
      ),
      tabPanel("Rate of Interest/Return",
        sidebarLayout(
          sidebarPanel(
            numericInput("basic.r.present", label = "Present Value", value = 100),
            numericInput("basic.r.future", label = "Future Value", value = 100),
            sliderInput("basic.r.periods", label = "Number of Periods", min = 0, max = 50, step = 1, value = 5),
            submitButton("Calculate"),
            h3("Answer"),
            textOutput("basic.rate")
          ),
          mainPanel()
        )
      ),
      tabPanel("Rule of 72",
        sidebarLayout(
          sidebarPanel(
            numericInput("basic.rs.years", label = "Years", value = 6),
            numericInput("basic.rs.rate", label = "Interest Rate", value = 12),
            submitButton("Calculate"),
            h3("Answer"),
            textOutput("basic.rs.value")
          ),
          mainPanel()
        )
      )
    )
  ),
  tabPanel("Loan Amortization",
    sidebarLayout(
      sidebarPanel(
        numericInput("loan.amount", label = "Loan Amount", value = 1000),
        sliderInput("loan.interest", label = "Interest Rate (Annual)", min = 0, max = 20, step = 1, value = 5),
        sliderInput("loan.time", label = "Loan Term (Years)", min = 0, max = 50, step = 1, value = 10),
        selectInput("loan.calc", label = "Calculate", choices = list("Annually" = 0, "Quarterly" = 1, "Monthly" = 2)),
        radioButtons("loan.annuity", label = "Withdrawal Type", choices = list("Ordinary (End of Period)" = 1, "Annuity Due (Start of Period)" = 0)),
        submitButton("Calculate")
      ),
      mainPanel(
        tableOutput("loan.table")
      )
    )
  ),
  tabPanel("Investment",
    sidebarLayout(
      sidebarPanel(
        numericInput("inv.amount", label = "Initial Deposit", value = 1000),
        numericInput("inv.cont", label = "Periodic Contribution", value = 100),
        radioButtons("inv.annuity", label = "Contribution Type", choices = list("Ordinary (End of Period)" = 1, "Annuity Due (Start of Period)" = 0)),
        sliderInput("inv.interest", label = "Interest Rate", min = 0, max = 20, step = 1, value = 5),
        sliderInput("inv.time", label = "Years", min = 0, max = 50, step = 1, value = 5),
        selectInput("inv.calc", label = "Calculate", choices = list("Annually" = 0, "Quarterly" = 1, "Monthly" = 2)),
        submitButton("Calculate"),
        h3("Answer"),
        textOutput("inv.value")
      ),
      mainPanel()
    )
  )
))
