require "pry"

cart = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

new_cart = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}
coupons = {:item => "AVOCADO", :num => 2, :cost => 5.0}

def consolidate_cart(cart)
  # code here
  new_hash = {}
  
  cart.each do |arrray|
    arrray.each do |key, value|
      if new_hash.has_key?(key) == false
        new_hash[key] = value 
        new_hash[key][:count] = 1
      elsif new_hash.has_key?(key)
        new_hash[key][:count] += 1
      end
      
    end
  end
  new_hash
end




def apply_coupons(cart, coupons)
# new_hash = {}

  coupons.each do |coupon_hash|
    item = coupon_hash[:item]
      if cart[item] && cart[item][:count] >= coupon_hash[:num]
        cart[item][:count] -= coupon_hash[:num]
        if cart["#{item} W/COUPON"]
          cart["#{item} W/COUPON"][:count] += 1
        else
          cart["#{item} W/COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[item][:clearance], :count => 1}
        end
      
  end
  end
  cart
end



def apply_clearance(cart)
  
  cart.each do |item, hash|
    if hash[:clearance] == true
      hash[:price] = (hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  checkout_total = 0
   
  consol_cart = consolidate_cart(cart)
  applied_cart = apply_coupons(consol_cart, coupons)
  final_cart = apply_clearance(applied_cart)
  
  final_cart.each do |item,info|
    checkout_total += info[:price] * info[:count].to_f 
  end
  if checkout_total > 100
  checkout_total = checkout_total * 0.90
  else
    checkout_total 
  end
  checkout_total
end
