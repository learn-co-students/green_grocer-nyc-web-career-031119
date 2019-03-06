def consolidate_cart(cart)
  answer = {}
  cart.each do |cart_hash|
    cart_hash.each do |fruit, vals|
      if answer[fruit].nil?
        answer[fruit] = vals.merge({:count => 1})
      else
        answer[fruit][:count] += 1
      end
    end
  end
  answer
end

def apply_coupons(cart, coupons)
  # code here
answer = {}
  cart.each do |fruit, info|
    coupons.each do |coupon|
      if fruit == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] = info[:count] - coupon[:num]
        if answer["#{fruit} W/COUPON"]
          answer["#{fruit} W/COUPON"][:count] += 1
        else
          answer["#{fruit} W/COUPON"] = {price: coupon[:cost], clearance: info[:clearance], count: 1}
        end
      end
    end
    answer[fruit] = info
  end
  answer
end

def apply_clearance(cart)
  # code here
  cart.each do |fruit, info|
    if info[:clearance] == true
      info[:price] = info[:price] - (info[:price]*0.2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  foo =[]
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |fruit, info|
    total += (info[:price] * info[:count]).to_f
  end
  if total > 100
    total = total*0.9
  end
  total
end
