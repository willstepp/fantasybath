#product types
p = ProductType.where(:name => "Fizzy").first
if p.nil?
  ProductType.create(:name => "Fizzy")
end

p = ProductType.where(:name => "Bulk Powder").first
if p.nil?
  ProductType.create(:name => "Bulk Powder")
end

p = ProductType.where(:name => "Perfume Spray").first
if p.nil?
  ProductType.create(:name => "Perfume Spray")
end

p = ProductType.where(:name => "Candle").first
if p.nil?
  ProductType.create(:name => "Candle")
end

p = ProductType.where(:name => "Shea Butter Bar").first
if p.nil?
  ProductType.create(:name => "Shea Butter Bar")
end

p = ProductType.where(:name => "Bath Tart").first
if p.nil?
  ProductType.create(:name => "Bath Tart")
end


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