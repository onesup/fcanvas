module ApplicationHelper
  def number_to_image_tag(number)
    number = "%07d" % number
    parts = number.split(".")
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
  
  def fans_to_boxes(heros)
    donate_unit_won = 5000
    stage1 = 10000000
    stage2 = 30000000
    stage3 = 50000000
    box_value = stage1 / 20
    stage1_boxes = stage1 / box_value
    stage2_boxes = (stage2 / box_value) - stage1_boxes
    stage3_boxes = (stage3 / box_value) - (stage1_boxes + stage2_boxes)
    total_boxes = stage1_boxes + stage2_boxes + stage3_boxes
    donated_boxes = (heros * donate_unit_won) / box_value
    stage1_result = stage1_boxes - donated_boxes
    total_stock = total_boxes - donated_boxes
    stage1_result = stage1_boxes 
    stage2_result = stage2_boxes
    stage3_result = stage3_boxes
    stage1_stock = total_stock - (stage2_boxes + stage3_boxes) > 0 ? total_stock - (stage2_boxes + stage3_boxes) : 0
    if (stage1_boxes + stage3_boxes) - donated_boxes > 0
      stage2_stock = (stage1_boxes + stage3_boxes) - donated_boxes
    elsif (stage1_boxes + stage3_boxes) - donated_boxes > stage2_boxes
    else
      stage2_stock = 0
    end
    if donated_boxes > (stage1_boxes + stage2_boxes)
      stage3_stock = total_stock
    else
      stage3_stock = stage3_boxes
    end
    [[stage1_boxes, stage1_stock], [stage2_boxes, stage2_stock], [stage3_boxes, stage3_stock]]
  end
  
  def render_stage1(heros)
    stocks = fans_to_boxes(heros)[0]
    boxes = stocks.first
    stocks = stocks.last
    if stocks == 20
      blanks = '<li class="blank"></li>' * stocks
      result = blanks
    elsif stocks < 20 and stocks >= 10
      blanks2 = '<li class="blank"></li>' * (stocks - 10)
      fills1 = '<li class="fill_01"></li>' * (boxes - stocks)
      blanks1 = '<li class="blank"></li>' * 10
      result = blanks1 + fills1 + blanks2
    elsif stocks < 9
      # blanks1 = '<li class="blank"></li>' * (10)
      blanks1 = '<li class="blank"></li>' * (stocks)
      fills1 = '<li class="fill_01"></li>' * ((boxes - stocks) - 10)
      fills2 = '<li class="fill_01"></li>' * 10 
      result = fills1 + blanks1 + fills2
    end
    result
  end
  
  def time_iterate(start_time, end_time, step, &block)
    begin
      yield(start_time)
    end while (start_time += step) <= end_time
  end
  
end
