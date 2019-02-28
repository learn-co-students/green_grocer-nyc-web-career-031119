def consolidate_cart(cart)
  cart.each_with_object({}) do |element, new_ele|
    element.each do |item, parameters|
      if new_ele[item]
        parameters[:count] += 1
      else
        parameters[:count] = 1
        new_ele[item] = parameters
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |ele|
    name = ele[:item]
    if cart[name] && cart[name][:count] >= ele[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => ele[:cost], :clearance => cart[name][:clearance], :count => 1}
      end
      cart[name][:count] -= ele[:num]
    end
  end
  cart
    
end

def apply_clearance(cart)
  cart.each do |name, parameters|
    if parameters[:clearance]
      price = parameters[:price] * 0.80
      parameters[:price] = price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consol_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consol_cart, coupons)
  final_cart = apply_clearance(coupon_cart)
  total = 0
  final_cart.each do |name, parameters|
    total += parameters[:price] * parameters[:count]
  end
  if total > 100
    total *= 0.9
  end
  total
  
  
end
