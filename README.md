* clone repo
* cd into repo
* bundle install
* rails db:setup (seed will take a bit)
* rails c
* Generate.new.call

```ruby
# app/services/generate.rb
class Generate
  require 'benchmark'

  def initialize
    @users    = User.all
    @invoices = Invoice.all
  end

  def call

    good = Benchmark.measure do good_way end
    bad  = Benchmark.measure do bad_way end

    puts "Good Way: #{good}"
    puts " Bad Way: #{bad}"

  end

private

  def bad_way
    hash = {}
    @users.each do |user|
      hash[user.id] = user.invoices.sum(:total)
    end

    return hash
  end

  def good_way
    hash = {}
    @invoices.group_by(&:user_id).each do |user_invoices|
      hash[user_invoices[0]] = user_invoices[1].map(&:total).inject(0, :+)
    end

    return hash
  end

end
```
