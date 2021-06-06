class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :with_paginate_10, lambda { |page| paginate(page: (page || 1), per_page: 10) }

end
