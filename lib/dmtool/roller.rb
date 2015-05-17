module DMTool::Roller
  def self.roll(*dice)
    dice.map(&:roll)
  end

  def self.sum(*dice)
    roll(*dice).inject(:+)
  end
end
