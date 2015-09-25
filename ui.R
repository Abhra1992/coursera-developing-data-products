library(shiny)
shinyUI(navbarPage("Finance Calculator",
  tabPanel("Time Value of Money",
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
          mainPanel(
            h3("Basic Present Value and Future Value Calculations"),
            p("Money and Asset values fluctuate over time. Future Value is the value of an asset at a specific date in the future. Assuming a certain interest rate, or rate of return, it can measure the future some of money that the given asset is worth at a speicifed date in the future."),
            h4("Using the form"),
            p("To determine the future value using compund interest, select the Future Value option from the Calculate menu, specify the present value of the asset in the Amount field, and use the sliders to customise the time period in Years and set the Interest Rate. Press Calculate and the result appears in the Answer."),
            p("You can use the same form to calculate the Present Value for a given asset value on the future. Just Select the Present Value option in the Calculate menu.")
          )
        )
      ),
      tabPanel("Number of Periods",
        sidebarLayout(
          sidebarPanel(
            numericInput("basic.p.present", label = "Present Value", value = 100),
            numericInput("basic.p.future", label = "Future Value", value = 200),
            sliderInput("basic.p.interest", label = "Interest Rate", min = 0, max = 20, step = 1, value = 5),
            submitButton("Calculate"),
            h3("Answer"),
            textOutput("basic.period")
          ),
          mainPanel(
            h3("Calculating number of periods"),
            p("Given a present value and a future value of an asset, you can calculate the amount of time required for the asset to attain that future value for a specified interest rate."),
            h4("Using the form"),
            p("Fill in the Present Value and Future Value for the asset and use the slider to set the Interest Rate. Pressing Calculate will compute the Time period required and display in the Answer.")
          )
        )
      ),
      tabPanel("Rate of Interest/Return",
        sidebarLayout(
          sidebarPanel(
            numericInput("basic.r.present", label = "Present Value", value = 100),
            numericInput("basic.r.future", label = "Future Value", value = 200),
            sliderInput("basic.r.periods", label = "Number of Periods", min = 0, max = 50, step = 1, value = 5),
            submitButton("Calculate"),
            h3("Answer"),
            textOutput("basic.rate")
          ),
          mainPanel(
            h3("Calculating Rate of Return"),
            p("Given a present value and a future value of an asset, you can calculate the Rate of Return (Rate of Interest) required for the asset to attain that future value in a specified period of time."),
            h4("Using the form"),
            p("Fill in the Present Value and Future Value for the asset and use the slider to set the Time Period. Pressing Calculate will compute the Rate of Return and display in the Answer.")
          )
        )
      )
    )
  ),
  tabPanel("Loan Amortization",
    h3("Amortizing Loan Calculator"),
    p("An amortizing loan is a loan where the principal of the loan is paid down over the life of the loan (amortized) according to a schedule, typically through equal payments (such as EMIs). Each repayment consists of a portion of the principal and a portion of the interest. The following amoritzation calculator can be used to tabulate the amortization expenses during the acquisition of the asset."),
    h4("Using the calculator"),
    p("Use the calculator to adjust the loan amount until the periodic payments fit comfortably into your budget. You can vary the Interest Rate, and the term of the loan in Years. You can customise the repayment cycle using the Calculate menu. You can also choose whether you are going to repay the instalment at the beginning or at the end of each repayment cycle."),
    h4("Using the plot"),
    p("The Amortization Plot can help you figure out (when used along with the Amortization table) the exact dollar amount that goes towards the interest and the principal in each individual repayment."),
    sidebarLayout(
      sidebarPanel(
        numericInput("loan.amount", label = "Loan Amount", value = 1000),
        sliderInput("loan.interest", label = "Interest Rate (Annual)", min = 0, max = 20, step = 1, value = 5),
        sliderInput("loan.time", label = "Loan Term (Years)", min = 0, max = 50, step = 1, value = 20),
        selectInput("loan.calc", label = "Calculate", choices = list("Annually" = 0, "Quarterly" = 1, "Monthly" = 2)),
        radioButtons("loan.annuity", label = "Repayment Type", choices = list("Ordinary (End of Period)" = 1, "Annuity Due (Start of Period)" = 0)),
        submitButton("Calculate")
      ),
      mainPanel(
        tabsetPanel(type = "tabs",
          tabPanel("Amortization Table", tableOutput("loan.table")),
          tabPanel("Amortization Plot", plotOutput("loan.plot"))
        )
      )
    )
  ),
  tabPanel("Investment Annuities",
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
      mainPanel(
        h3("Annuities in Investment"),
        p("An annuity is a series of equal payments or receipts that occur at evenly spaced intervals. The payments or receipts can correspond to an investment that starts of with an initial capital, and grows with equal contributions periodically."),
        h4("Using the calculator"),
        p("Use the calculator to compute the net amount to which an anuuity will grow with an initial capital with periodic payments. Fill in the Initial Deposit with a Periodic Contribution. Use the sliders to set the interest rate and the time period. Use the Calculate menu to selct whether the contributions and the compunding is calculated annually, monthly, or quarterly."),
        p("Note that the value in the Periodic Contribution field must correspond to the period in the Calculate menu. For example, if you are calculating Annually, then the Contribution field should have the value of the annual deposit. Press calculate to view the Answer."),
        p("The plot below shows the value to which the investment grows with each time period."),
        plotOutput("inv.plot")
      )
    )
  )
))
