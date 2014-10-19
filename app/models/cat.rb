class Cat < ActiveRecord::Base
  validates :name, presence: true, length: { in: 2..255 }

  scope :visible, -> { where(visible: true) }
  scope :hidden,  -> { where(visble: false) }
end
