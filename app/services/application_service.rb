class ApplicationService
  def self.visit_block(*args, &block)
    new(*args, &block).visit_block
  end
end