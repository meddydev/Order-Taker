require "order_taker"

describe Menu do
    it "constructs" do
        expect { Menu.new }.not_to raise_error
    end

    it "lists menu with all dishes and corresponding prices" do
        menu = Menu.new
        expect(menu.list).to eq "Chicken Butterfly: £8.25\nGrilled Chicken Burger: £6.75\nBean Wrap: £6.75\nChips: £2.95\nTap Water: £0.00\nPepsi: £1.50"
    end

    it "initially raises error when trying to see receipt" do
        menu = Menu.new
        expect { menu.receipt }.to raise_error "No selections have been made."
    end

    it "raises error when trying to select a dish that isn't on the menu" do
        menu = Menu.new
        expect { menu.select("bargain bucket") }.to raise_error "This dish is not on the menu."
    end

    it "shows correct receipt after selecting one item from the menu" do
        menu = Menu.new
        menu.select("Bean Wrap")
        expect(menu.receipt).to eq "Bean Wrap: £6.75\nTotal: £6.75"
    end

    it "shows correct receipt after selecting multiple items from the menu" do
        menu = Menu.new
        menu.select("Chicken Butterfly")
        menu.select("Chips")
        expect(menu.receipt).to eq "Chicken Butterfly: £8.25\nChips: £2.95\nTotal: £11.20"
    end

    it "shows correct receipt after adding and removing an item" do
        menu = Menu.new
        menu.select("Chicken Butterfly")
        menu.select("Chips")
        menu.remove("Chips")
        expect(menu.receipt).to eq "Chicken Butterfly: £8.25\nTotal: £8.25"
    end

    context "when tring to remove a dish from the order when it hasn't been selected" do
        it "raises an error" do
            menu = Menu.new
            menu.select("Chicken Butterfly")
            expect { menu.remove("Chips") }.to raise_error "This dish has not been selected."
        end
    end

    it "shows correct receipt when adding multiple of the same item" do
        menu = Menu.new
        menu.select("Chips")
        menu.select("Chips")
        menu.select("Chips")
        expect(menu.receipt).to eq "Chips: £2.95\nChips: £2.95\nChips: £2.95\nTotal: £8.85"
    end

    it "shows correct receipt when adding multiple of the same item and then removing one of them" do
        menu = Menu.new
        menu.select("Chips")
        menu.select("Chips")
        menu.select("Chips")
        menu.remove("Chips")
        expect(menu.receipt).to eq "Chips: £2.95\nChips: £2.95\nTotal: £5.90"
    end

    it "raises error when trying to confirm order when nothing has been selected" do
        menu = Menu.new
        expect {menu.confirm_order}.to raise_error "Cannot confirm order: no dishes have been selected."
    end

    context "after confirming order" do
        it "raises error when tring to select dish" do
            menu = Menu.new
            menu.select("Chicken Butterfly")
            menu.select("Chips")
            menu.confirm_order
            expect { menu.select("Chips") }.to raise_error "Order already confirmed. Cannot select new items."
        end

        it "raises error when tring to remove dish" do
            menu = Menu.new
            menu.select("Chicken Butterfly")
            menu.select("Chips")
            menu.confirm_order
            expect { menu.remove("Chips") }.to raise_error "Order already confirmed. Cannot remove items."
        end
    end
end