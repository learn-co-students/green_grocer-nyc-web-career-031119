require 'pry'
def consolidate_cart(cart)
  consolidated = {}
    cart.each do |unit|
    unit.each do |item, stats|
      if consolidated[item].nil?
        consolidated[item] = stats.merge({:count => 1})
      else
        consolidated[item][:count] += 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  answer = cart
  coupons.each do |coupon|
    item = coupon[:item]

    if !answer[item].nil? && answer[item][:count] >= coupon[:num]
      withcoup = {"#{item} W/COUPON" => {
        :price => coupon[:cost],
        :clearance => answer[item][:clearance],
        :count => 1
        }
      }

      if answer["#{item} W/COUPON"].nil?
        answer.merge!(withcoup)
      else
        answer["#{item} W/COUPON"][:count] += 1
      end

      answer[item][:count] -= coupon[:num]
    end
  end
  answer
end

def apply_clearance(cart)
  cart.each do |item, pricing|
    if pricing[:clearance] == true
      pricing[:price] = (pricing[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
  cart = consolidate_cart(items)
  cartcoupons = apply_coupons(cart, coupons)
  cartclearance = apply_clearance(cartcoupons)

  total = 0

  cartclearance.each do |name, pricing|
    total += pricing[:price] * pricing[:count]
  end

  total > 100 ? total * 0.9 : total

end
