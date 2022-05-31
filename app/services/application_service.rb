class ApplicationService
  def self.find_budgets(*args, &block)
    new(*args, &block).find_budgets
  end
end