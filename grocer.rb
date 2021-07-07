require "pry"

def consolidate_cart(cart)
  uniq_cart = cart.uniq
  counting_items = Hash.new(0)
  uniq_cart_hash = {}
  
  cart.each do |item|
    counting_items[item] += 1
  end
  
  uniq_cart.each do |item1|
    item1.each do |key1, value1|
      uniq_cart_hash[key1] = value1
    end
  end
  
  uniq_cart_hash.each do |uniq_info|
    uniq_info.each do |uniq_item, uniq_cost|
      counting_items.each do |duplicate_item, quantity|
        duplicate_item.each do |key, value|
          if uniq_item == key
            uniq_cart_hash[uniq_item][:count] = quantity
          end
        end
      end
    end
  end
  uniq_cart_hash
end

def apply_coupons(cart, coupons)
  # counting_coupons = Hash.new(0)
  cart_with_coupons = {}
  
  # coupons.each do |coupon|
  #   counting_coupons[coupon[:item]] += 1
  # end
  
  cart.each do |key, value|
    cart_with_coupons[key] = value
  end

  cart.each do |name, info|
    coupons.each do |discount|
      if discount[:item] == name
        if !cart_with_coupons["#{name} W/COUPON"]
          cart_with_coupons["#{name} W/COUPON"] = {:price => discount[:cost]}
          cart_with_coupons["#{name} W/COUPON"].merge!(:clearance => info[:clearance])
        end
        
        if discount[:num] <= cart_with_coupons[name][:count]
    
            if !cart_with_coupons["#{name} W/COUPON"][:count]
        
              cart_with_coupons["#{name} W/COUPON"].merge!(:count => 1)
              
            else
            
              cart_with_coupons["#{name} W/COUPON"][:count] =  cart_with_coupons["#{name} W/COUPON"][:count] + 1
            
            end
            
          cart_with_coupons[name][:count] = cart_with_coupons[name][:count] - discount[:num]
          
        end
      end
    end
  end
  cart_with_coupons
end

def apply_clearance(cart)
  clearance_cart = {}
  
  cart.each do |key, value|
    clearance_cart[key] = value
  end
  
  cart.each do |name, info|
    if info[:clearance]
      clearance_cart[name][:price] = (info[:price] * 0.8).round(2)
    end
  end
  
  clearance_cart
  
end

def checkout(cart, coupons)
  total = 0
  coupons_cart = apply_coupons(consolidate_cart(cart), coupons)
  clearanced_cart = apply_clearance(coupons_cart)
  
  clearanced_cart.each do |name, info|
    total = total + (info[:price] * info[:count])
  end
  
  if total > 100
    total = total * 0.90
  end
  
  total.round(2)
end
