 def consolidate_cart(cart)
  # code here
  hash = {}
  count = 0
    cart.each do |item|
      item.each do |food, value|
       hash[food] ||= value
       hash[food][:count] ||= 0
       hash[food][:count] += 1    
     end
    end 
  return hash
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  coupon_food = coupon[:item]
   if cart[coupon_food] && cart[coupon_food][:count] >= coupon[:num]
    if cart["#{coupon_food} W/COUPON"]
       cart["#{coupon_food} W/COUPON"][:count] +=1
    else
      cart["#{coupon_food} W/COUPON"] = {:price => coupon[:cost], :count => 1, :clearance => cart[coupon_food][:clearance]}
    end
    cart[coupon_food][:count]= cart[coupon_food][:count] -= coupon[:num]
    end
  end
  cart
end 

# def apply_clearance(cart)
#   # code here
#   cart.each do |key, value|
#     if value[:clearance] == true
#     value[:price] = value[:price] - (value[:price]*0.20)
#     end 
#   end
# end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if value[:clearance] == true
     updated_price = value[:price] * 0.80
      value[:price] = updated_price.round(2)
    end 
  end
  cart
end

def checkout(cart, coupons)
  # code here
total = 0
new_cart = consolidate_cart(cart)
coupon_cart = apply_coupons(new_cart, coupons)
final_cart = apply_clearance(coupon_cart)
  final_cart.each do |item_name, properties|
    total += properties[:price]*properties[:count]
  end
       if total > 100 
       total = total - (total*0.10)
       end
 total
 end
