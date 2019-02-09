def consolidate_cart(cart)
  # code here
  new_cart = {}#consolicates cart and adds any quantities together
  cart.each_with_index do |item, i|
    item.each do |food, data|
      if new_cart[food]
        new_cart[food][:count]+= 1
      else
        new_cart[food] = data
        new_cart[food][:count] = 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  with_coupon = {}
  cart.each do |items, info|
    coupons.each do |coupon|
      if items == coupon[:item] && info[:count] >= coupon[:num] #doesn't break if exceeds number
        info[:count] -= coupon[:num]
        if with_coupon["#{items} W/COUPON"]
          with_coupon["#{items} W/COUPON"][:count] +=1
        else
          with_coupon["#{items} W/COUPON"] = {price: coupon[:cost],
            clearance: info[:clearance], count: 1}
          end
        end
      end
      with_coupon[items] = info
    end
    with_coupon
end

def apply_clearance(cart)
  # code here
cart_clear = {}
cart.each do |items, info|
  cart_clear[items] = {}
    if info[:clearance] == true
      cart_clear[items][:price] = info[:price] * 4 / 5
    else
      cart_clear[items][:price] = info[:price]
    end
    cart_clear[items][:clearance] = info[:clearance]
    cart_clear[items][:count] = info[:count]
  end
  cart_clear
end

def checkout(cart, coupons)#totals cart, applies coupons and discount if > 100
  consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupons_cart)
  total_price = 0.00
  final_cart.each do |items,info|
    total_price += info[:price] * info[:count]
  end
  if total_price > 100.00
    total_price = total_price * 0.9
  end
  return total_price
end
