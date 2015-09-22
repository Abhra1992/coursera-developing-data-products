library(shiny)
shinyServer(function(input, output){
  basic.calc <- reactive({as.integer(input$basic.calc)})
  basic.amount <- reactive({as.numeric(input$basic.amount)})
  basic.interest <- reactive({as.numeric(input$basic.interest)})
  basic.time <- reactive({as.integer(input$basic.time)})

  inflation <- function(interest, time) {
    (1 + interest/100) ^ time
  }

  present <- function(future, interest, time) {
    future * inflation(interest, time)
  }

  future <- function(present, interest, time) {
    present / inflation(interest, time)
  }

  value <- function(value_type, amount, interest, time) {
    if(value_type == 0) {
      paste("Present Value =", present(amount, interest, time))
    } else {
      paste("Future Value =", future(amount, interest, time))
    }
  }

  loan.calc <- reactive({as.integer(input$loan.calc)})
  loan.amount <- reactive({as.numeric(input$loan.amount)})
  loan.interest <- reactive({as.numeric(input$loan.interest)})
  loan.time <- reactive({as.integer(input$loan.time)})
  loan.annuity <- reactive({as.integer(input$loan.annuity)})

  repay <- function(amount, interest, time, ordinary = TRUE) {
    inf <- inflation(interest, time)
    inf2 <- inf
    if(!ordinary) {
      inf2 <- inf / (1 + interest/100)
    }
    amount * (interest/100) * inf2 / (inf - 1)
  }

  periods.calc <- function(calc) {
    periods <- 1
    if(calc == 1) {
      periods <- 4
    } else if(calc == 2) {
      periods <- 12
    }
    periods
  }

  loan.table <- function(calc, amount, interest, time, annuity) {
    periods <- periods.calc(calc)
    int <- interest / periods
    t <- time * periods
    instalment <- repay(amount, int, t, ordinary = annuity == 1)
    table <- data.frame()
    balance <- amount
    cum_interest <- 0
    for(i in 1:t) {
      interest_paid <- balance * int / 100
      principal_repaid <- instalment - interest_paid
      ending_balance <- balance - principal_repaid
      cum_interest <- cum_interest + interest_paid
      table <- rbind(table, data.frame(Year = i, Balance = balance, Instalment = instalment, InterestPaid = interest_paid, PrincipalRepayment = principal_repaid, EndingBalance = ending_balance, CumulativeInterest = cum_interest))
      balance <- ending_balance
    }
    table
  }

  basic.p.present <- reactive({as.numeric(input$basic.p.present)})
  basic.p.future <- reactive({as.numeric(input$basic.p.future)})
  basic.p.interest <- reactive({as.numeric(input$basic.p.interest)})

  periods <- function(present, future, interest) {
    log((future / present), base = inflation(interest, 1))
  }

  basic.r.present <- reactive({as.numeric(input$basic.r.present)})
  basic.r.future <- reactive({as.numeric(input$basic.r.future)})
  basic.r.periods <- reactive({as.numeric(input$basic.r.periods)})

  rate <- function(present, future, periods) {
    (((future / present) ^ (1 / periods)) - 1) * 100
  }

  inv.amount <- reactive({as.numeric(input$inv.amount)})
  inv.cont <- reactive({as.numeric(input$inv.cont)})
  inv.interest <- reactive({as.numeric(input$inv.interest)})
  inv.time <- reactive({as.integer(input$inv.time)})
  inv.calc <- reactive({as.integer(input$inv.calc)})
  inv.annuity <- reactive({as.integer(input$inv.annuity)})

  growth.contribution <- function(cont, interest, time, annuity) {
    inf <- inflation(interest, time)
    inf1 <- 1
    if(annuity == 0) {
      inf1 <- inflation(interest, 1)
    }
    cont * ((inf1 * (inf - 1))/(interest/100))
  }

  growth <- function(amount, cont, interest, time, calc, annuity) {
    periods <- periods.calc(calc)
    int <- interest / periods
    t <- time * periods
    inf <- inflation(int, t)
    amount * inf + growth.contribution(cont, int, t, annuity)
  }

  output$basic.value <- renderText({ value(basic.calc(), basic.amount(), basic.interest(), basic.time()) })
  output$loan.table <- renderTable({ loan.table(loan.calc(), loan.amount(), loan.interest(), loan.time(), loan.annuity()) })
  output$basic.period <- renderText({ periods(basic.p.present(), basic.p.future(), basic.p.interest()) })
  output$basic.rate <- renderText({ paste(rate(basic.r.present(), basic.r.future(), basic.r.periods()), "%") })
  output$inv.value <- renderText({ growth(inv.amount(), inv.cont(), inv.interest(), inv.time(), inv.calc(), inv.annuity()) })
})
