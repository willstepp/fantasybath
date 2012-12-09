module PriceTester
  def self.test_pennies_to_dollars(p, d)
    puts "Pennies: #{p}"
    dollars = Price.pennies_to_dollars(p)
    puts "Dollars: #{dollars}"
    d == dollars ? "Passed" : "Failed"
  end

  def self.test_dollars_to_pennies(d, p)
    puts "Dollars: #{d}"
    pennies = Price.dollars_to_pennies(d)
    puts "Pennies: #{pennies}"
    p == pennies ? "Passed" : "Failed"
  end
end