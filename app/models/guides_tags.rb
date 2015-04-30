class GuidesTags < ActiveRecord::Base
  belongs_to :guide
  belongs_to :tag
end
