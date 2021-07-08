require 'pry'

def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each do |item|
    item.each do |item_name, attributes|
      attributes.each do |attribute, value|
        if !new_hash.has_key?(item_name)
          new_hash[item_name] = {attribute => value}
          new_hash[item_name][:count] = 1
        elsif new_hash.has_key?(item_name) && !new_hash[item_name].has_key?(attribute)
          new_hash[item_name][attribute] = value
        elsif new_hash.has_key?(item_name) && new_hash[item_name].has_key?(attribute)
          new_hash[item_name][:count] += 1
          break
        end
      end
    end
  end
  cart = new_hash
  cart
end

def apply_coupons(cart, coupons)
  # code here
  new_hash = {}
  cart.each do |item_name, attributes|
    if coupons.size > 0
      coupons.each do |coupon|
        if coupon.has_value?(item_name)
          new_hash[item_name] = attributes
          new_hash[item_name][:count] = cart[item_name][:count] - coupon[:num]
          # EDIT: new_hash[item_name][:count] = new_hash[item_name][:count] - coupon[:num]
          if !new_hash.has_key?("#{item_name} W/COUPON")
            new_hash["#{item_name} W/COUPON"] = {
              price: coupon[:cost],
              clearance: attributes[:clearance],
              count: 1
            }
          elsif new_hash.has_key?("#{item_name} W/COUPON")
            new_hash["#{item_name} W/COUPON"][:count] += 1
            # the below if statement is an edit
            if new_hash[item_name][:count] < 0
              new_hash[item_name][:count] = new_hash[item_name][:count] + coupon[:num]
              new_hash["#{item_name} W/COUPON"][:count] -= 1
            end
          end
        else
          new_hash[item_name] = attributes
        end
      end
    else
      attributes.each do |attribute, value|
        new_hash[item_name] = attributes
      end
    end
  end
  cart = new_hash
  cart
end

def apply_clearance(cart)
  # code here
  new_hash = {}
  cart.each do |item_name, attributes|
    attributes.each do |attribute, value|
      if attribute == :clearance && value == true
        new_hash[item_name] = attributes
        new_hash[item_name][:price] = (cart[item_name][:price] * 0.8).round(1)
      elsif attribute == :clearance && value == false
        new_hash[item_name] = attributes
      end
    end
  end
  cart = new_hash
  cart
end

def checkout(cart, coupons)
  # code here
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  discount_cart = apply_clearance(coupon_cart)
  total = 0
  discount_cart.each do |item_name, attributes|
    total += attributes[:price] * attributes[:count]
  end
  if total > 100
    total = total * 0.9
  end
  #binding.pry
  total
end
