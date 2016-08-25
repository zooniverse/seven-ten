class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def with_retry(error:, attempts:)
    try_count = 0
    begin
      yield
    rescue error => e
      try_count += 1
      try_count < attempts ? retry : raise(e)
    end
  end
end
