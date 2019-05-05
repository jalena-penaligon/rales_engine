class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :best_day do |object|
    object.best_day = object.best_day.to_s[0..9]
  end
end
