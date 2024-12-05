class Day5
  attr_reader :input

  def initialize(task_input_fetcher: TaskInputFetcher.new)
    @input = task_input_fetcher.call(5)
  end

  def part1
    input
    ordering_raw, programs_raw = input.split("")
    ordering = ordering_raw.map { |rule| rule.split('|').map(&:to_i) }.group_by(&:shift).transform_values(&:flatten)
    programs = programs_raw.map { |program| program.split(',').map(&:to_i) }
    programs.sum { |program|
      all_good = true
      program.each_with_index { |page, i|
        all_good = false if shit?(page, i, program, ordering)
      }
      if all_good
        program[(program.size - 1) / 2]
      else
        0
      end
    }
  end

  def part2
    # input
  end

  def shit?(page, i, program, ordering)
    if (followers = ordering[page])
      followers.intersection(program[0..i]).present?
    else
      false
    end
  end
end
