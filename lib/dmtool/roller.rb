module DMTool::Roller
  def self.roll(dice, directives)
    ret_val = dice.map do |die|
      directives.each_with_object(die) do |directive, ret|
        directive.process(ret)
      end
    end
    ret_val
  end

  def self.sum(dice, directives)
    roll(dice, directives).map(&:value).inject(0, :+)
  end
end
