// Step 1 - Ask for name
let name = "Joe";

// Step 2 - Select a Product
//let builder = BurgerBuilder.getBuilder(burgerType: Burgers.bigburger);
let builder = BurgerBuilder.getBuilder(burgerType: .BIGBURGER)

// Step 3 - Customize burger?
builder.setMayo(choice: false);
builder.setCooked(choice: Burger.Cooked.WELLDONE);

let order = builder.buildObject(name: name);

order.printDescription();
