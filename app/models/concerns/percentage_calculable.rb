module Concerns::PercentageCalculable
  extend ActiveSupport::Concern

  # NOTE The result of this method is not accurate.
  #      In some cases, total of results is not be 100%.
  #      However I would like to give priority to the simplicity.
  #      See also the link -> http://stackoverflow.com/questions/5227215/how-to-deal-with-the-sum-of-rounded-percentage-not-being-100
  def percents_of(numbers)
    return Array.new(numbers.size, 0) if numbers.all?(&:zero?)

    total = numbers.sum

    numbers.map {|number|
      ((number / total.to_f) * 100).round
    }
  end
end
