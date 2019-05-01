class Revenue
  attr_reader :id, :total_revenue
  def initialize(total_revenue)
    @id = 1
    @total_revenue = total_revenue
  end
end
