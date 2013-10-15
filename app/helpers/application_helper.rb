module ApplicationHelper
  def number_to_image_tag(number)
    parts = number.to_s.split(".")
    parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
    numbers = parts.join
    numbers = numbers.gsub(/./){|s| '<li class="num">' + s + '</li>'}
    numbers = numbers.gsub(/\<li class\=\"num\"\>\,\<\/li\>/){|s| '<li>,</li>'}
  end
  
  def number_to_bing_image_tag(number)
    parts = number.to_s.split(".")
    parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
    numbers = parts.join
    numbers = numbers.gsub(/./){|s| '<li class="num">' + s + '</li>'}
    numbers = numbers.gsub(/\<li class\=\"num\"\>\,\<\/li\>/){|s| '<li>,</li>'}
  end
  
end
