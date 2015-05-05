class ContentsGuides < ActiveRecord::Base
  belongs_to :content
  belongs_to :guide
end
