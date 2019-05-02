class RevenueByDaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_revenue do |object|
    object.total_revenue = (object.total_revenue.to_f/100).to_s
  end
end
