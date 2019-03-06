def consolidate_cart(cart)
  new_cart = {}
  cart.each_with_index do |item, i|
    item.each do |food, data|
      if new_cart[food]#Need clarification
        new_cart[food][:count]+= 1#increases count
      else
        new_cart[food] = data#Passes data from food to consolidate_cart
        new_cart[food][:count] = 1#Adds count attribute
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coup_hash = {}
  cart.each do |food, data|
    coupons.each do |coupon|
      if food == coupon[:item] && data[:count] >= coupon[:num]#matching distcountable items
        data[:count] = data[:count] - coupon[:num]#Need clarification
        if coup_hash["#{food} W/COUPON"]#Need clarification
          coup_hash["#{food} W/COUPON"][:count] += 1#Need clarification
        else
          coup_hash["#{food} W/COUPON"] = {price: coupon[:cost], clearance: data[:clearance], count: 1}#Need clarification
        end
      end
    end
    coup_hash[food] = data#Need clarification
  end
  coup_hash
end



def apply_clearance(cart)
  cart.each do |food, data|
    if data[:clearance]#if item is clearance
      price = data[:price] * 0.80#Discount %80
      data[:price] = price.round(2)#Rounds price to 2 demical places
    end
  end
  cart
end


def checkout(cart, coupons)
  consol_cart = consolidate_cart(cart)#Consolidates
  coupon_cart = apply_coupons(consol_cart, coupons)#Applies coupon
  final_cart = apply_clearance(coupon_cart)#Applies clearance
  total = 0
  final_cart.each do |name, parameters|#iterates through cart
    total += parameters[:price] * parameters[:count]#calculates total price and total items
  end
  if total > 100#Applies discount if greater than 100
    total *= 0.9
  end
  total
end
#I found this lab to be incredibly difficult and copied code from fellow students in order to better understand solution.
#Will review named parameters and advanced hash methods going forward.
