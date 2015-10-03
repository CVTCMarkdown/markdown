module DashboardHelper
  def darkened_tag (tag)
    highscore = @tags.first.taggings_count.to_d
    myscore = tag.taggings_count.to_d
    ratio = (myscore**5 / highscore**5)#(myscore**highscore / highscore) / (highscore**highscore / highscore)
    saturation = (ratio) * 10 + 70
    lightness = (1 - ratio) * 50 + 20
    whiteText = "color:white;" unless lightness >= 70
    render html: "<span class=\"tag\" style=\"color:white;background:hsl(220, #{saturation}%, #{lightness}%)\" data-tag-count=\"#{myscore}\">#{tag.name}</span>".html_safe
  end
end
