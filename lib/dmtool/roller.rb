module DMTool::Roller
  def self.roll(*dice)
    dice.map(&:roll)
  end
end
