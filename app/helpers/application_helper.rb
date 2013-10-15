module ApplicationHelper
  def number_to_image_tag(number)
    parts = number.to_s.split(".")
    parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
    numbers = parts.join
    numbers = numbers.gsub(/./){|s| '<li class="num">' + s + '</li>'}
    numbers = numbers.gsub(/\<li class\=\"num\"\>\,\<\/li\>/){|s| '<li>,</li>'}
  end
  
  def number_to_big_image_tag(number)
    parts = number.to_s
    add_zeros = "0" * (7 - parts.length)
    parts = parts.insert(0, add_zeros)
    parts.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
    numbers = parts
    numbers = numbers.gsub(/./){|s| content_tag(:div, image_tag('page_tab/num/' + s + '.jpg'), class: "n")}
    numbers = numbers.gsub(/\<div class\=\"n\"\>\<img alt\=\"\,\" src\=\"\/images\/page\_tab\/num\/\,\.jpg\" \/\>\<\/div\>/){|s| '<div class="n spacer">&nbsp</div>'}
  end
  
end
