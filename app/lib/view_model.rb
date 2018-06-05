class ViewModel < SimpleDelegator
  def model
    __getobj__
  end

  def self.collection(models)
    models.map { |m| self.new(m) }
  end
end
