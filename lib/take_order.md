1. Describe the Problem
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

(Use the twilio-ruby gem to implement this next one. You will need to use doubles too.)

As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.

2. Design the Class System

┌─────────────────────────────────────────────────────────────┐
│   Menu                                                      │
│                                                             │
│   list (shows menu and prices)                              │
│                                                             │
│   order (select menu items you want)                        │
│                                                             │
│   receipt (returns itemised receipt with total price)       │
│                                                             │
│   text (uses twilio to text customer with an arrival time)  │
│                                                             │
│   confirm_order (finalises order)                           │
│                                                             │
└─────────────────────────────────────────────────────────────┘

(had some new thoughts about the design)

class Menu

    def initialize
        @menu = {} # hash of dishes and prices
        @selection = {} # hash of dishes chosen and their prices
        @confirm = false
    end

    def list
        # returns nicely formatted list of dishes and prices (by looping through the hash probs)
    end

    def select(dish)
        # doesn't return anything, just adds dish (and its price) to a new array or hash
        # fails if dish isn't in @menu
        # fail "can't select item, already ordered" if confirm has been called
    end

    def remove(dish)
        # doesn't return anything, just removes dish (and corresponding price) from the order array/hash
        # fails if dish isn't in @selection
        # fail "can't remove item, already ordered' if confirm has been called
    end

    def receipt
        # returns nicely formatted itemised receipt (your selections add up to £X.XX)
        # potentially wording is different if order has been confirmed or not
    end

    def confirm_order
        @confirm = true
        # places order, customer gets text
    end
end