require 'twilio-ruby'

class Menu
    def initialize
        @menu = {
            "Chicken Butterfly" => "8.25",
            "Grilled Chicken Burger" => "6.75",
            "Bean Wrap" => "6.75",
            "Chips" => "2.95",
            "Tap Water" => "0.00",
            "Pepsi" => "1.50"
        }
        @selections = []
        @confirm = false
    end

    def list
        formatted_list = ""
        @menu.each do |dish, price|
            formatted_list += "#{dish}: £#{price}\n"
        end
        return formatted_list.chomp
        puts formatted_list.chomp
    end

    def select(dish)
        fail "Order already confirmed. Cannot select new items." if @confirm
        fail "This dish is not on the menu." unless @menu.include?(dish)
        @selections << dish
    end

    def remove(dish)
        fail "Order already confirmed. Cannot remove items." if @confirm
        fail "This dish has not been selected." unless @selections.include?(dish)
        @selections.delete_at(@selections.index(dish))
    end

    def receipt
        fail "No selections have been made." if @selections.empty?
        formatted_receipt = ""
        total_price = 0
        @selections.each do |selection|
            total_price += @menu[selection].to_f
            formatted_receipt += "#{selection}: £#{@menu[selection]}\n"
        end
        if total_price.round(1) == total_price
            formatted_receipt += "Total: £#{total_price}0"
        else
            formatted_receipt += "Total: £#{total_price.round(2)}"
        end
        return formatted_receipt
        puts formatted_receipt
    end

    def confirm_order
        fail "Cannot confirm order: no dishes have been selected." if @selections.empty?
        @confirm = true
        arrival_time = Time.now + 30*60
        arrival_time_string = arrival_time.strftime("%k:%M")
        my_phone_number = ENV['MY_PHONE_NUMBER']
        
        account_sid = ENV['TWILIO_ACCOUNT_SID']
        auth_token = ENV['TWILIO_AUTH_TOKEN']

        @client = Twilio::REST::Client.new(account_sid, auth_token)
        message = @client.messages.create(
            body: "Thank you! Your order was placed and will be delivered before #{arrival_time_string}",
            to: my_phone_number,
            from: "+18453902211")
        puts messade.sid
    end

    def confirmed?
        @confirm
    end
end