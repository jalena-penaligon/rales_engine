class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue do |object|
    object.revenue = (object.revenue.to_f/100).to_s
  end

end
