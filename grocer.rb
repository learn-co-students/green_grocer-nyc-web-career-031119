def consolidate_cart(cart)
 sorted = Hash.new
 count = Hash.new(0)
  cart.each do|hash|
   hash.each do|food, info_hash|
    sorted[food] = info_hash
    count[food] += 1
   sorted[food][:count] = count[food]
 end
 end
 return sorted
  # code here
end

def apply_coupons(cart, coupons)
     coupons.each do|coupon|
      name = coupon[:item]
    if cart.keys.include?(name) && cart[name][:count]>=coupon[:num]
    cart[name][:count] -= coupon[:num]
    if cart["#{name} W/COUPON"]
    cart["#{name} W/COUPON"][:count] += 1
   else
    cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
    cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
    end
    end
  end
  return cart
  # code here
end

def apply_clearance(cart)
 cart.each do|green, info_hash|
  if info_hash.values.include?(true)
   info_hash[:price] = (info_hash[:price] * 0.8).round(1)
  end
  end
   cart
  # code here
end

def checkout(cart, coupons)
  total = 0
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  final_cart.each do|green, info_hash|
  total += info_hash[:price] * info_hash[:count]
  end
  if total > 100
    total *= 0.9
  else
    total
  end
  
  # code here
end
