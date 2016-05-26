class JobPosting < ActiveRecord::Base
	has_many :candidates, dependent: :destroy
end
