/datum/book_entry/brewing
	name = "How to Brew"
	category = "Instructions"

/datum/book_entry/brewing/inner_book_html(mob/user)
	return {"
	<div>
	<h2>How to Brew:</h2>
	To brew, you start by getting an empty barrel and then filling it with some kind of liquid - usually water.<br>
	Then you add the ingredients needed for the recipe, such as fruits, vegetables or grains.<br>
	Then, you can left click on the barrel to start brewing.<br>
	Beware, brewing will clear all of the existing reagents in the barrel, so make sure you start with an empty barrel.<br>
	You can also right-click on the barrel to clear it, this will also clear the reagents. If you do this by mistake, walk away to interrupt your action.<br> 
	<div>
	<h2>Distillation and Multi-Step Recipes</h2>
	Some recipes require you to distill the product you made, or to brew it multiple times.<br>
	To perform those recipes, brew the prerequisite product first, then left click on the barrel / distillery without tapping or bottling it.<br>
	You must use the same container without tapping or bottling it throughout the entire chain of recipes.<br>
	Then, you can add in any needed ingredients to the barrel / distillery and left click it again to start the next step of the recipe.<br>
	Distillery requires heat to work, and is fueled by a full log or a piece of coal. Adding it to the distillery will help you maintain the correct temperature for distilling.<br>
	</div>
	<h2>Tapping, Bottling and Selling your Products</h2>
	Each barrel gain a sell price inclusive of the barrel's original price and the product's sell price, upon a brew being completed.<br>
	You can tap a brewed barrel with middle-click. This allows you to fill a container from it.<br>
	Note that reagents are not stored in the actual reagent container and instead it will display as (Alcohol Name): 100% or something similar.<br>
	Tapping a barrel will remove its sell price. <br>
	You can also bottle a barrel's product by left clicking on it with a bottling kit, which will empty the barrel and give you named bottles of the product.<br>
	The bottles inherit the sellprice of the product but divided by the number of bottles you get. Usually it must be sold at the merchant as the individual price are too low.<br>
	Opening the bottle will reduce its sell price to 0.<br> 
	</div>
	"}
