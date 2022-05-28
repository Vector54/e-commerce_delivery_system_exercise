module ApplicationHelper
  def money_format(money_integer)
    money_str = money_integer.to_s
    if money_integer < 100 && money_integer >= 10
      money_str.insert(0, '0').insert(-3, ',')
    elsif money_integer < 10
      money_str.insert(0, '00').insert(-3, ',')
    else
      money_str.insert(-3, ',')
    end
    return money_str
  end
end
