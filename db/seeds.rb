#scent categories
s = ScentCategory.where(:name => "Floral").first
if s.nil?
  ScentCategory.create(:name => "Floral")
end

s = ScentCategory.where(:name => "Fruit").first
if s.nil?
  ScentCategory.create(:name => "Fruit")
end

s = ScentCategory.where(:name => "Spice").first
if s.nil?
  ScentCategory.create(:name => "Spice")
end

s = ScentCategory.where(:name => "Autumn").first
if s.nil?
  ScentCategory.create(:name => "Autumn")
end

s = ScentCategory.where(:name => "Winter").first
if s.nil?
  ScentCategory.create(:name => "Winter")
end

s = ScentCategory.where(:name => "Spring").first
if s.nil?
  ScentCategory.create(:name => "Spring")
end

s = ScentCategory.where(:name => "Summer").first
if s.nil?
  ScentCategory.create(:name => "Summer")
end

s = ScentCategory.where(:name => "Exotic").first
if s.nil?
  ScentCategory.create(:name => "Exotic")
end