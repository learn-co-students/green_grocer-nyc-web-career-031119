def consolidate_cart(cart)
  new = {}
  cart.each { |product_hash|
    product_hash.each { |item,item_hash|
      if new.has_key?(item)
        new[item][:count] += 1
      else
        new[item] = item_hash
        new[item][:count] = 1
      end
    }
  }
  new
end

def apply_coupons(cart, coupons)
  coupons.each { |coupon_hash|
    item = coupon_hash[:item]
    if cart.has_key?(item)
      originalQ = cart[item][:count]
      couponQ = originalQ / coupon_hash[:num]
      appliedQ = originalQ % coupon_hash[:num]
        if couponQ > 0
          cart[item][:count] = appliedQ
          cart["#{item} W/COUPON"] = {
            price: coupon_hash[:cost],
            clearance: cart[item][:clearance],
            count: couponQ
          }
        end
      end
  }
  cart
end

def apply_clearance(cart)
  cart.each { |item,item_hash|
    if cart[item][:clearance] == true
      cart[item][:price] = (cart[item][:price]*0.8).round(2)
    end
  }
end

def checkout(cart, coupons)
  total = 0
  consolidated = consolidate_cart(cart)
  couponsApplied = apply_coupons(consolidated,coupons)
  clearanceApplied = apply_clearance(couponsApplied)

  new = consolidated.map { |item,key|
    key[:price] * key[:count]
  }
  new.each { |cost|
    total += cost
  }
  if total >= 100
    total = (total * 0.9).round(2)
  end
  total
end
